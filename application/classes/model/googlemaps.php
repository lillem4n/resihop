<?php defined('SYSPATH') OR die('No direct access allowed.');

/**
 * Provides simple stuff to google maps API
 *
 */
class Model_Googlemaps extends Model
{

	public static $instance = FALSE;

	public function __construct()
	{
		parent::__construct();
	}

	/**
	 * Returns a singleton instance of Googlemaps.
	 *
	 * @return	Googlemaps
	 */
	public static function instance()
	{
		if (!self::$instance)
		{
			// Create a new instance
			self::$instance = new Googlemaps();
		}

		return self::$instance;
	}

	public function get_address_by_coordinates($lat, $lon)
	{
		if (is_float($lat) && is_float($lon))
		{
			$sql = 'SELECT address FROM google_cache WHERE lat = '.$lat.' AND lon = '.$lon;
			foreach ($this->pdo->query($sql) as $row)
			{
				return $row['address'];
			}
		}

		return FALSE;
	}

	public function get_coordinates_by_address($search_string)
	{
		// First lets see if we got this search in our cache

		$sql = 'SELECT * FROM google_cache WHERE search_string = '.$this->pdo->quote($search_string);

		foreach ($this->pdo->query($sql) as $row)
		{
			// Result is cached, just return it
			if ($row['lat'] === NULL)
			{
				// There is no location for this search string (Google error code 602)
				return FALSE;
			}
			else
			{
				return array(
					'lat'     => (float) $row['lat'],
					'lon'     => (float) $row['lon'],
					'address' => $row['address'],
				);
			}
		}

		// No exact match found, lets look at multiple loocations

		$sql = 'SELECT * FROM google_cache_multiple_locations WHERE search_string = '.$this->pdo->quote($search_string);

		$addresses = array();
		foreach ($this->pdo->query($sql) as $row)
		{
			$addresses[] = $row['address'];
		}

		if (count($addresses))
		{
			// Multiple entries found in cache, return the different addresses
			return $addresses;
		}

		// Nothing found, lets ask Google

		$dom = new DomDocument();
		$dom->load('http://maps.google.com/maps/geo?q='.urlencode($search_string).'&output=xml&oe=utf8&sensor=false&key='.Kohana::config('google.key'));

		$XPath = new DOMXPath($dom);
		$XPath->registerNamespace('m', 'http://earth.google.com/kml/2.0');

		$dom_status_codes = $XPath->query('/m:kml/m:Response/m:Status/m:code');

		$status_code = FALSE;
		foreach ($dom_status_codes as $dom_status_code)
		{
			$status_code = $dom_status_code->nodeValue;
		}

		if ($status_code == '200')
		{
			// 200 means ok, cool

			$entries = $XPath->evaluate('count(/m:kml/m:Response/m:Placemark)');
			if ($entries == 1)
			{
				// Only one match, perfect!

				// Mkay, get the coordinates and address and save it to the database
				$dom_coordinates = $XPath->query('/m:kml/m:Response/m:Placemark[@id=\'p1\']/m:Point/m:coordinates');

				$coordinates = FALSE;
				foreach ($dom_coordinates as $dom_coordinate)
				{
					list($coordinates['lat'], $coordinates['lon']) = explode(',', $dom_coordinate->nodeValue);
				}

				$dom_addresses = $XPath->query('/m:kml/m:Response/m:Placemark[@id=\'p1\']/m:address');
				foreach ($dom_addresses as $dom_address)
				{
					$address = $dom_address->nodeValue;
				}

				if ($coordinates)
				{
					$this->pdo->exec('
						INSERT INTO google_cache
						(`lon`, `lat`, `search_string`, `address`)
						VALUES
						(
							'.$coordinates['lon'].',
							'.$coordinates['lat'].',
							'.$this->pdo->quote($search_string).',
							'.$this->pdo->quote($address).'
						);'
					);

					return array(
						'lat'	    => $coordinates['lat'],
						'lon'	    => $coordinates['lon'],
						'address' => $address
					);
				}
				else
				{
					return FALSE; // Should not happend...
				}
			}
			else
			{
				// Multiple entries, return the different addresses

				$addresses     = array();
				$dom_addresses = $XPath->query('/m:kml/m:Response/m:Placemark/m:address');

				foreach ($dom_addresses as $dom_address)
				{
					$this->pdo->exec('INSERT INTO google_cache_multiple_locations (search_string, address) VALUES('.$this->pdo->quote($search_string).','.$this->pdo->quote($dom_address->nodeValue).');');
					$addresses[] = $dom_address->nodeValue;
				}

				return $addresses;
			}
		}
		elseif ($status_code == '602')
		{
			// Address not found
			$this->pdo->exec('INSERT INTO google_cache (`search_string`, `address`) VALUES('.$this->pdo->quote($search_string).','.$this->pdo->quote($search_string).');');
			return FALSE;
		}
		else
		{
die('Google api thingy status code: ' . $status_code . '. Query: ' . $search_string . ' If you see this, please report to info@resihop.nu');
			return FALSE;
		}
	}

	/**
	 * Get distance between two coordinates
	 *
	 * @param float $lat1 - First points latitude
	 * @param float $lon1 - First points longitude
	 * @param float $lat2 - Second points latitude
	 * @param float $lon2 - Second points longitude
	 * @return float Distance in kilometers
	 */
	public function get_distance_between_coordinates($lat1, $lon1, $lat2, $lon2) {
		return (3958*3.1415926*sqrt(($lat2-$lat1)*($lat2-$lat1) + cos($lat2/57.29578)*cos($lat1/57.29578)*($lon2-$lon1)*($lon2-$lon1))/180);
	}

	/**
	 * Check if this is a valid address
	 *
	 * @param str $address
	 * @return bool
	 */
	public static function valid_address($address) {
		$googlemaps = Googlemaps::instance();
		if ($google_result = $googlemaps->get_coordinates_by_address($address)) {
			if (array_keys($google_result) == array('lat', 'lon', 'address')) {
				return TRUE;
			}
		}

		return FALSE;
	}

}
