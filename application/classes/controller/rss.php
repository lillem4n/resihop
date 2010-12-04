<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_sitemap extends Resihopcontroller
{

	public function __construct()
	{
		// This is needed for the XSLT setup
		parent::__construct();
		$this->force_transform = TRUE;
	}

	public function action_index()
	{
		// Set the name of the template to use
		$this->xslt_stylesheet = 'search';

		$trips_node = $this->xml_content->appendChild($this->dom->createElement('trips'));

		if (count($_GET))
		{
			$googlemaps = Googlemaps::instance();

			$get = new Validate($_GET);
			$get->filter(TRUE,     'trim');
			$get->filter(TRUE,     'urldecode');
			$get->label('q',       '');
			$get->label('from',    '');
			$get->label('to',      '');
			$get->label('when',    '');
			$get->label('got_car', '');

			if (isset($get['when']) && !strtotime($get['when']))
			{
				$this->add_error('Invalid format', array('param' => 'when'));
			}
			elseif (isset($get['when']) && strtotime($get['when']) < time())
			{
				$this->add_error('Must select a time in the future', array('param' => 'when'));
			}

			foreach (array('from','to') as $place)
			{
				if (isset($get[$place]) && $get[$place] != '')
				{
					$q_google_result = $googlemaps->get_coordinates_by_address($get[$place]);
					if ($q_google_result == FALSE)
					{
						$this->add_error('Invalid address', array('param' => $place));
						$get->error($place, 'Invalid address');
					}
					elseif (array_keys($q_google_result) != array('lat','lon','address'))
					{
						$addresses  = $googlemaps->get_coordinates_by_address($get[$place]);
						$data       = array(
							'param' => $place,
						);
						foreach ($addresses as $nr => $address)
						{
							$data[$nr.'option'] = $address;
						}
						$this->add_error('Address is not unique', $data);
					}
				}
				elseif (isset($get[$place]) && $get[$place] == '')
				{
					$this->add_error('Invalid address', array('param' => $place));
					$get->error($place, 'Invalid address');
				}
			}

			$googlemaps = Googlemaps::instance();
			if (isset($get['q']))
			{
				xml::to_XML(Trip::get_trips($get['q']), $trips_node, 'trip');
			}
			elseif (isset($get['from']) || isset($get['to']) || isset($get['when']) || isset($get['got_car']))
			{
				if (!isset($get['from']))    $get['from']    = FALSE;
				if (!isset($get['to']))      $get['to']      = FALSE;
				if (!isset($get['when']))    $get['when']    = FALSE;
				if (!isset($get['got_car'])) $get['got_car'] = FALSE;
				else                         $get['got_car'] = (int)$get['got_car'];
				xml::to_XML(
					Trip::get_trips(FALSE, $get['from'], $get['to'], strtotime($get['when']), $get['got_car']),
					$trips_node,
					'trip'
				);
			}
		}
		else
		{
			xml::to_XML(Trip::get_trips(), $trips_node, 'trip');
		}
	}

}
