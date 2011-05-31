<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Edittrip extends Resihopcontroller
{

	public function action_index()
	{
		// Set the name of the template to use
		$this->xslt_stylesheet = 'edittrip';

		if (count($_POST) && isset($_POST['code']))
		{
			$post = new Validate($_POST);
			$post->filter(TRUE, 'trim');

			if ($trip_id = Trip::get_trip_id_by_code($post['code']))
			{
				$trip = new Trip($trip_id);

				if (isset($post['remove']))
				{
					if ($trip->rm_trip())  xml::to_XML(array('message' => 'Trip removed'), $this->xml_content);
					else                   $this->add_error('Unknown error', array('description' => 'Tried to remove trip ' . $trip_id));
				}
				else
				{
					$new_data = array();

					foreach (array('from', 'to') as $field)
					{
						if (isset($post[$field]))
						{
							if (Googlemaps::valid_address($post[$field]))  $new_data[$field] = $post[$field];
							else
							{
								$googlemaps = Model_Googlemaps::instance();
								$addresses  = $googlemaps->get_coordinates_by_address($post[$field]);
								$data       = array(
									'param' => $field,
								);
								if ($addresses)
								{
									foreach ($addresses as $nr => $address)
									{
										$data[$nr.'option'] = $address;
									}
									$this->add_error('Address is not unique', $data);
								}
								else $this->add_error('Invalid address', $data);
							}
						}
					}

					if (isset($post['when']))
					{
						if (!strtotime($post['when']))              $this->add_error('Invalid format', array('param' => 'when'));
						elseif (strtotime($post['when']) < time())  $this->add_error('Must be a future timestamp', array('param' => 'when'));
						else                                        $new_data['when'] = strtotime($post['when']);
					}

					if (isset($post['email']))
					{
						if (Validate::email($post['email']))  $new_data['email'] = $post['email'];
						else                                  $this->add_error('Invalid format', array('param' => 'email'));
					}

					if (isset($post['got_car']))
					{
						$new_data['got_car'] = (bool)$post['got_car'];
					}

					foreach (array('name', 'details') as $field)
					{
						if (isset($post[$field]) && strlen($post[$field]) > 0)  $new_data[$field] = $post[$field];
					}

					if (isset($post['phone']))
					{
						if (Trip::validate_phone($post['phone'])) $new_data['phone'] = $post['phone'];
						else                                      $this->add_error('Invalid format', array('param' => 'phone'));
					}

					if (!isset($this->errors))
					{
						foreach ($new_data as $field => $data)
						{
							$method_name = 'set_'.$field;
							if ($field == 'from' || $field == 'to')
							{
								$googlemaps = Model_Googlemaps::instance();
								$coords     = $googlemaps->get_coordinates_by_address($data);
								if (!$trip->$method_name($coords['lat'], $coords['lon']))
								{
									$this->add_error('Unknown error', array('param' => $field));
									break;
								}
							}
							else
							{
								if (!$trip->$method_name($data))
								{
									$this->add_error('Unknown error', array('param' => $field));
									break;
								}
							}
						}
						xml::to_XML(array('message' => 'Data saved'), $this->xml_content);
					}
					xml::to_XML(array('trip_data' => $trip->get_trip_data()), $this->xml_content);
				}
			}
			else $this->add_error('Invalid', array('param' => 'code'));
		}
		else $this->add_error('Required', array('param' => 'code'));


	}

}
