<?php defined('SYSPATH') or die('No direct script access.');

class Model_Trip extends Model
{

	public $trip_id;

	public $from;
	public $from_lat;
	public $from_lon;
	public $to;
	public $to_lat;
	public $to_lon;
	public $when;
	public $details;
	public $got_car;
	public $inserted;
	public $name;
	public $email;
	public $phone;
	public $code;

	/**
	 * Full trip data
	 */
	public $trip_data;

	public function __construct($trip_id)
	{
		parent::__construct();

		return $this->set_trip_id($trip_id);
	}

	/**
	 * Add trip
	 *
	 * @param str $from - Must be a unique address
	 * @param str $to - Must be a unique address
	 * @param num $when - UNIX timestamp
	 * @param str $details
	 * @param int $got_car - 1 or 0
	 * @param str $name
	 * @param str $email
	 * @param str $phone
	 * @param arr $errors - passed by reference, so we can use if (Trip::add_trip())
	 * @return obj - Object instance of the new trip
	 *				 or
	 *				 arr - Array of errors
	 */
	public static function add_trip($from, $to, $when, $details, $got_car, $name, $email, $phone)
	{
		$pdo           = Kohana_pdo::instance();
		$googlemaps    = Model_Googlemaps::instance();
		$errors        = array();
		$new_trip_data = array(
											 'details' => $details,
											 'name'    => $name,
											 'email'   => $email,
											 'phone'   => $phone,
										 );

		if ($from_coordinates = $googlemaps->get_coordinates_by_address($from))
		{
			if (!isset($from_coordinates['lat']))
			{
				$errors[] = 'From-address is not unique.';
			}
			else
			{
				$new_trip_data['from_lat'] = $from_coordinates['lat'];
				$new_trip_data['from_lon'] = $from_coordinates['lon'];
			}
		}
		else
		{
			$errors[] = 'Invalid from-address.';
		}

		if ($to_coordinates = $googlemaps->get_coordinates_by_address($to))
		{
			if (!isset($to_coordinates['lat']))
			{
				$errors[] = 'To-address is not unique.';
			}
			else
			{
				$new_trip_data['to_lat'] = $to_coordinates['lat'];
				$new_trip_data['to_lon'] = $to_coordinates['lon'];
			}
		}
		else
		{
			$errors[] = 'Invalid to-address.';
		}

		if (!preg_match('/^[0-9]{1,}/', $when)) $errors[] = 'Invalid when. Must be a UNIX timestamp.';
		else                                    $new_trip_data['when'] = $when;

		if ($got_car !== 1 && $got_car !== 0)   $errors[] = 'got_car must be either (int)1 or (int)0.';
		else                                    $new_trip_data['got_car'] = $got_car;

		// Check for duplicate
		if ( ! count($errors))
		{
			$sql = 'SELECT trip_id FROM trips WHERE
				details  = '.$pdo->quote($new_trip_data['details']) .' AND
				name     = '.$pdo->quote($new_trip_data['name'])    .' AND
				email    = '.$pdo->quote($new_trip_data['email'])   .' AND
				phone    = '.$pdo->quote($new_trip_data['phone'])   .' AND
				from_lat = '.floatval($new_trip_data['from_lat'])   .' AND
				from_lon = '.floatval($new_trip_data['from_lon'])   .' AND
				to_lat   = '.floatval($new_trip_data['to_lat'])     .' AND
				to_lon   = '.floatval($new_trip_data['to_lon'])     .' AND
				`when`   = '.$pdo->quote($new_trip_data['when'])    .' AND
				got_car  = '.$pdo->quote($new_trip_data['got_car']) .'
				 ;';

			if ($pdo->query($sql)->fetchColumn() > 0)
			{
				$errors[] = 'This trip is a duplicate';
			}

		}

		if (count($errors)) return $errors;
		else
		{
			$sql = 'INSERT INTO trips (';
			$tmp = '';

			foreach ($new_trip_data as $field => $data)
			{
				$sql .= '`'.$field.'`,';
				$tmp .= $pdo->quote($data).',';
			}

			$code = Text::random('distinct', 12);
			while ($pdo->query('SELECT trip_id FROM trips WHERE code = '.$pdo->quote($code))->fetchColumn())
			{
				$code = Text::random('distinct', 12);
			}

			$sql .= 'inserted,code) VALUES('.$tmp.time().','.$pdo->quote($code).');';

			$pdo->exec($sql);

			$new_trip = new Trip($pdo->lastInsertId());

			return $new_trip;
		}

	}

	/**
	 * Email the code to this trips email
	 *
	 * @param str $locale - sv_SE, en_US etc
	 * @return bol
	 */
	public function email_code($locale)
	{
		if (in_array($locale, array('sv_SE')))
		{
			mail(
				$this->email,
				utf8_decode('Redigeringskod från resihop.nu'),
				utf8_decode('Du får det här mailet för att du beställt en redigeringskod från resihop.nu!
Klicka på länken nedan för att ändra inställningarna för din resa.

http://'.$_SERVER['HTTP_HOST'].'/edittrip?code='.$this->code.'

- eller -

Gå in på http://'.$_SERVER['HTTP_HOST'].'//edittrip
och skriv in följande kod:

'.$this->code.'

Klicka på "ändra resa"'),
				'From: Resihop.nu <noreply@resihop.nu>'
			);
			return true;
		}
		else return false;
	}

	/**
	 * Get trip data
	 *
	 * @param str $field - If specified, return a specific field
	 * @param bol $private_data - return code, TRUE or FALSE
	 * @return arr (or str if specific field)
	 */
	public function get_trip_data($field = FALSE, $private_data = FALSE)
	{
		if (!$this->trip_id)
		{
			return FALSE;
		}

		if ($field)
		{
			if (isset($this->$field))
			{
				if ($field == 'when_iso')
				{
					return date('Y-m-d H:i', $this->when);
				}
				else
				{
					return $this->$field;
				}
			}
			else
			{
				return FALSE;
			}
		}
		else
		{
			$data = array(
				'trip_id'      => $this->trip_id,
				'from'         => $this->from,
				'from_lat'     => $this->from_lat,
				'from_lon'     => $this->from_lon,
				'to'           => $this->to,
				'to_lat'       => $this->to_lat,
				'to_lon'       => $this->to_lon,
				'when'         => $this->when,
				'when_iso'     => date('Y-m-d H:i', $this->when),
				'details'      => $this->details,
				'got_car'      => $this->got_car,
				'inserted'     => $this->inserted,
				'name'         => $this->name,
				'email'        => $this->email,
				'phone'        => $this->phone,
			);

			if ($private_data)
			{
				$data['code'] = $this->code;
			}

			return $data;
		}
	}

	public static function get_trip_id_by_code($code)
	{
		$pdo = Kohana_pdo::instance();
		return $pdo->query('SELECT trip_id FROM trips WHERE code = '.$pdo->quote($code).';')->fetchColumn();
	}

	/**
	 * Get trip ids by email
	 *
	 * @param str $email
	 * @return arr - array of ints
	 */
	public static function get_trip_ids_by_email($email)
	{
		$pdo      = Kohana_pdo::instance();
		$trip_ids = array();

		foreach ($pdo->query('SELECT trip_id FROM trips WHERE email = '.$pdo->quote($email).';') as $row)
		{
			$trip_ids[] = $row['trip_id'];
		}

		return $trip_ids;
	}

	/**
	 * Get trips
	 *
	 * @param str $q - Free form search on to and from address
	 * @param str $from - From address
	 * @param str $to - To address
	 * @param num $when - UNIX timestamp
	 * @param int $got_car - 1 or 0, FALSE will ignore this param
	 * @param arr $trip_ids - array of ints
	 * @return arr
	 */
	public static function get_trips($q = FALSE, $from = FALSE, $to = FALSE, $when = FALSE, $got_car = FALSE, $trip_ids = FALSE)
	{
		$pdo        = Kohana_pdo::instance(); // Get database instance, since we are in a static method
		$googlemaps = Googlemaps::instance(); // Get google maps instance

		// Empty string means FALSE
		if ($from == '') $from = FALSE;
		if ($to   == '') $to   = FALSE;
		if ($when == '') $when = FALSE;

		// Start constructing the SQL
		$sql = '
			SELECT
				trip_id,
				from_lon,
				from_lat,
				to_lon,
				to_lat,
				`when`,
				got_car,
				details,
				inserted,
				name,
				phone,
				(SELECT address FROM google_cache WHERE `lon` = from_lon AND lat = from_lat LIMIT 1) AS `from`,
				(SELECT address FROM google_cache WHERE `lon` = to_lon AND lat = to_lat LIMIT 1) AS `to`
			FROM `trips`
			WHERE
				`when` > ' . time();

		// If $got_car is supplied, add it to the WHERE clause
		if			($got_car === 0) $sql .= ' AND got_car = 0';
		elseif	($got_car === 1) $sql .= ' AND got_car = 1';

		// If $when is supplied, add it to the WHERE clause
		if ($when)
		{
			$sql .= ' AND `when` >= '.strtotime(date('Y-m-d', $when - Kohana::config('resihop.time_dif_in_sec_when_searching'))).' AND `when` <= ' . strtotime(date('Y-m-d', $when + Kohana::config('resihop.time_dif_in_sec_when_searching')));
		}

		// Specific trip ids should be included in the SQL
		if (is_array($trip_ids))
		{
			if (count($trip_ids))  $sql .= ' AND trip_id IN ('.implode(',', $trip_ids).')';
			else                   return array();
		}

		// Always sort by when the trip is about to happend
		$sql .= ' ORDER BY `when`';

		if ($q)
		{
			// $q means we search for _eeeverything_ !!! ... Right now that only means "to" and "from" tho...
			$coords = array();
			$q_google_result = $googlemaps->get_coordinates_by_address($q);
			if (array_keys($q_google_result) == array('lat','lon','address'))
			{
				// A single hit, add it to $coords for later matching
				$coords[] = array(
					'lat' => $q_google_result['lat'],
					'lon' => $q_google_result['lon'],
				);
			}
			elseif (is_array($q_google_result))
			{
				// Several hits. Add them all to $coords for later matching
				foreach ($q_google_result as $nr => $one_of_many)
				{
					$q_google_result_sub = $googlemaps->get_coordinates_by_address($one_of_many);
					if (is_array($q_google_result_sub) && array_keys($q_google_result_sub) == array('lat','lon','address'))
					{
						$coords[] = array(
							'lat' => $q_google_result_sub['lat'],
							'lon' => $q_google_result_sub['lon'],
						);
					}
				}
			}
		}
		else
		{
			// $q is not set, search for $to and $from separatly
			if ($to)
			{
				$to_google_result = $googlemaps->get_coordinates_by_address($to);
				if ($to_google_result == FALSE || array_keys($to_google_result) != array('lat','lon','address'))
				{
					// We require one hit only for $to, or this method will fail
					return FALSE;
				}
			}

			if ($from)
			{
				$from_google_result = $googlemaps->get_coordinates_by_address($from);
				if ($from_google_result == FALSE || array_keys($from_google_result) != array('lat','lon','address'))
				{
					// We require one hit only for $from, or this method will fail
					return FALSE;
				}
			}
		}

		$trips_data = array();
		$trip_ids   = array();
		// Fetch all matching trips from the database
		foreach ($pdo->query($sql, PDO::FETCH_ASSOC) as $row)
		{
			if ($to || $from || $q)
			{
				// If any of $to, $from or $q is set, we may need to filter out trips that do not match
				$add_this_trip = FALSE;

				if ($q)
				{
					// $q is special, it can be either $to or $from
					if (isset($coords) && is_array($coords))
					{
						foreach ($coords as $coord)
						{
							if
							(
								($row['to_lat']   == $coord['lat'] && $row['to_lon']   == $coord['lon']) ||
								($row['from_lat'] == $coord['lat'] && $row['from_lon'] == $coord['lon'])
							)
							{
								// This is an exact match, add this trip
								$add_this_trip = TRUE;
							}
							elseif
							(
								(distance::get_distance($row['to_lat'],   $row['to_lon'],   $coord['lat'], $coord['lon']) <= Kohana::config('resihop.min_search_radius')) ||
								(distance::get_distance($row['from_lat'], $row['from_lon'], $coord['lat'], $coord['lon']) <= Kohana::config('resihop.min_search_radius'))
							)
							{
								// The trip is not an exact match, but is within the radius
								$add_this_trip = TRUE;
							}
						}
					}

					if ($add_this_trip == FALSE)
					{
						// The trip got no hits for the coordinates, what about string match?
						if
						(
							str_replace(strtolower($q), '', strtolower($row['from'])) != strtolower($row['from']) ||
							str_replace(strtolower($q), '', strtolower($row['to']))   != strtolower($row['to'])
						)
						{
							// Some part of the string matched the strings from the other ones, add this trip
							$add_this_trip = TRUE;
						}
					}

				}
				else
				{
					if ($to && $from)
					{
						// Both $to and $from are set, lets find out if we should add this trip
						if ($row['to_lat'] == $to_google_result['lat'] && $row['to_lon'] == $to_google_result['lon'] && $row['from_lat'] == $from_google_result['lat'] && $row['from_lon'] == $from_google_result['lon'])
						{
							// Exact hit! Add this trip!
							$add_this_trip = TRUE;
						}
						else
						{
							// No direct hit, lets see if it's worth it to change the course of the trip to pick someone up
							$original_distance = distance::get_distance($row['from_lat'], $row['from_lon'], $row['to_lat'], $row['to_lon']);

							$new_distance =
								distance::get_distance($row['from_lat'], $row['from_lon'], $from_google_result['lat'], $from_google_result['lon']) +
								distance::get_distance($from_google_result['lat'], $from_google_result['lon'], $to_google_result['lat'], $to_google_result['lon']) +
								distance::get_distance($to_google_result['lat'], $to_google_result['lon'], $row['to_lat'], $row['to_lon']);

							if ($new_distance == 0 || $original_distance == 0)
							{
								// This should not happend... if it is, add this trip since we dont know the basic data needed to calculate the distances
								$add_this_trip = TRUE;
							}
							else
							{
								// We have both original and new distance, lets calc if they're less than acceptable in difference
								if (100 * (($new_distance / $original_distance) - 1) < Kohana::config('resihop.percent_extra_travel_distance_acceptable'))
								{
									// The new distance is not more than acceptable longer than the original one, add it!
									$add_this_trip = TRUE;
								}
							}
						}
					}
					elseif ($to)
					{
						if ($row['to_lat'] == $to_google_result['lat'] && $row['to_lon'] == $to_google_result['lon'])
						{
							// Exact hit! Add this trip!
							$add_this_trip = TRUE;
						}
						elseif (distance::get_distance($row['to_lat'], $row['to_lon'], $to_google_result['lat'], $to_google_result['lon']) <= Kohana::config('resihop.min_search_radius'))
						{
							// Its within min radius, add it
							$add_this_trip = TRUE;
						}
					}
					elseif ($from)
					{
						if ($row['from_lat'] == $from_google_result['lat'] && $row['from_lon'] == $from_google_result['lon'])
						{
							// Exact hit! Add this trip!
							$add_this_trip = TRUE;
						}
						elseif (distance::get_distance($row['from_lat'], $row['from_lon'], $from_google_result['lat'], $from_google_result['lon']) <= Kohana::config('resihop.min_search_radius'))
						{
							// Its within min radius, add it
							$add_this_trip = TRUE;
						}
					}
				}
			}
			else
			{
				// No filtering, add all trips
				$add_this_trip = TRUE;
			}

			if ($add_this_trip) {
				$trip_ids[]                              = $row['trip_id'];
				$trips_data[$row['trip_id']]             = $row;
				$trips_data[$row['trip_id']]['when_iso'] = date('Y-m-d H:i', $row['when']);
			}
		}

		if (count($trips_data))
		{
			return $trips_data;
		}

		return FALSE;
	}

	/**
	 * Remove this trip
	 *
	 * @return boolean
	 */
	public function rm_trip() {
		if ($this->trip_id)
		{
			$this->pdo->query('DELETE FROM trips WHERE trip_id = ' . $this->trip_id);

			unset($this);

			return TRUE;
		}

		return FALSE;
	}

	public function set_details($details)
	{
		if (is_string($details))
		{
			return $this->set_trip_data('details', $details);
		}

		return FALSE;
	}

	public function set_email($email)
	{
		if (Kohana_Validate::email($email))
		{
			return $this->set_trip_data('email', $email);
		}

		return FALSE;
	}

	public function set_from($lat, $lon)
	{
		return $this->set_trip_data('from', array($lat, $lon));
	}

	public function set_got_car($got_car)
	{
		if (is_bool($got_car))
		{
			return $this->set_trip_data('got_car', $got_car);
		}

		return FALSE;
	}

	public function set_name($name)
	{
		return $this->set_trip_data('name', $name);
	}

	public function set_phone($phone)
	{
		return $this->set_trip_data('phone', $phone);
	}

	public function set_to($lat, $lon)
	{
		return $this->set_trip_data('to', array($lat, $lon));
	}

	private function set_trip_data($field, $data)
	{
		if ($this->trip_id)
		{
			if ($field == 'from' || $field == 'to')
			{
				$googlemaps = Googlemaps::instance();
				if ($address = $googlemaps->get_address_by_coordinates($data[0], $data[1]))
				{
					if ($field == 'from')
					{
						$this->pdo->exec('UPDATE trips SET from_lat = '.$this->pdo->quote($data[0]).', from_lon = '.$this->pdo->quote($data[1]).' WHERE trip_id = '.$this->trip_id);
						$this->from_lat	= $data[0];
						$this->from_lon	= $data[1];
						$this->from     = $address;
					}
					elseif ($field == 'to')
					{
						$this->pdo->exec('UPDATE trips SET to_lat = '.$this->pdo->quote($data[0]).', to_lon = '.$this->pdo->quote($data[1]).' WHERE trip_id = '.$this->trip_id);
						$this->to_lat   = $data[0];
						$this->to_lon   = $data[1];
						$this->to       = $address;
					}
				}
				else
				{
					print_r($data);
					var_dump($googlemaps->get_address_by_coordinates($data[0], $data[1]));die();
					return FALSE;
				}
			}
			else
			{
				$this->pdo->exec('UPDATE trips SET `'.$field.'` = '.$this->pdo->quote($data).' WHERE trip_id = '.$this->trip_id);
				$this->$field = $data;
			}
			return TRUE;
		}

		return FALSE;
	}

	/**
	 * Set trip id
	 *
	 * @param int $trip_id
	 * @return boolean
	 */
	public function set_trip_id($trip_id)
	{
		$sql = '
			SELECT
				*,
				(SELECT address FROM google_cache WHERE `lon` = from_lon AND lat = from_lat LIMIT 1) AS `from`,
				(SELECT address FROM google_cache WHERE `lon` = to_lon AND lat = to_lat LIMIT 1) AS `to`
			FROM `trips`
			WHERE trip_id = '.$this->pdo->quote($trip_id).';';

		foreach ($this->pdo->query($sql) as $row)
		{
			$this->trip_id        = $row['trip_id'];
			$this->from           = $row['from'];
			$this->from_lat       = $row['from_lat'];
			$this->from_lon       = $row['from_lon'];
			$this->to             = $row['to'];
			$this->to_lat         = $row['to_lat'];
			$this->to_lon         = $row['to_lon'];
			$this->when           = $row['when'];
			$this->when_formatted = date('Y-m-d H:i', $row['when']);
			$this->details        = $row['details'];
			$this->got_car        = $row['got_car'];
			$this->inserted       = $row['inserted'];
			$this->name           = $row['name'];
			$this->phone          = $row['phone'];
			$this->email          = $row['email'];
			$this->code           = $row['code'];

			return TRUE;
		}

		return FALSE;
	}

	public function set_when($when)
	{
		if (preg_match('/^[0-9]+$/', $when))
		{
			return $this->set_trip_data('when', $when);
		}

		return FALSE;
	}

	public static function validate_phone($phone)
	{
		if (preg_match('/^[0-9\-\s\+\/]+$/', $phone))
		{
			return TRUE;
		}
		return FALSE;
	}

}
