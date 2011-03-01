<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Checkaddress extends Resihopcontroller
{

	public function action_index()
	{
		$this->transform = FALSE;

		if (isset($_GET['q']))
		{
			$googlemaps = new Googlemaps;
			$result     = $googlemaps->get_coordinates_by_address($_GET['q']);

			if (is_array($result) && array_keys($result) == array('lat', 'lon', 'address'))
			{
				xml::to_XML($result, $this->xml_content->appendChild($this->dom->createElement('match')));
			}
			elseif (is_array($result) && count($result))
			{
				$data = array();
				foreach ($result as $nr => $address) $data[$nr.'option'] = $address;
				$this->add_error('Address is not unique', $data);
			}
			else
			{
				$this->add_error('Invalid address');
			}
		}
		else
		{
			$this->add_error('Missing parameter: q');
		}
	}

}
