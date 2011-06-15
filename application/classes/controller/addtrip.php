<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Addtrip extends Resihopcontroller
{

	public function action_index()
	{
		// Set the name of the template to use
		$this->xslt_stylesheet = 'addtrip';

		if (count($_POST) && (isset($_POST['from']) || isset($_POST['to']) || isset($_POST['when']) || isset($_POST['name']) || isset($_POST['email']) || isset($_POST['phone'])))
		{
			$post = new Validate($_POST);
			$post->filter(TRUE,    'trim');

			$post->rule('from',    'not_empty');
			$post->rule('from',    'Googlemaps::valid_address');

			$post->rule('to',      'not_empty');
			$post->rule('to',      'Googlemaps::valid_address');

			$post->rule('when',    'not_empty');
			$post->rule('when',    'strtotime');

			$post->rule('name',    'not_empty');

			$post->rule('email',   'not_empty');
			$post->rule('email',   'email');

			$post->rule('phone',   'not_empty');
			$post->rule('phone',   'Trip::validate_phone');

			$post->label('details','');
			$post->label('got_car','');

			if ($post->check())
			{
				if (isset($post['got_car']) && $post['got_car'] == 1) $got_car = 1;
				else                                                  $got_car = 0;
				if (!isset($post['details']))                         $post['details'] = '';

				$new_trip = Trip::add_trip($post['from'], $post['to'], strtotime($post['when']), $post['details'], $got_car, $post['name'], $post['email'], $post['phone']);
				if (is_array($new_trip))
				{
					foreach ($new_trip as $error)
					{
						$this->add_error($error);
					}
				}
				else
				{
					xml::to_XML(array('new_trip' => $new_trip->get_trip_data(FALSE, TRUE)), $this->xml_content);
				}
			}
			else
			{
				foreach ($post->errors() as $field => $error_data)
				{
					if     ($error_data[0] == 'not_empty')                 $this->add_error('Required',        array('param' => $field));
					elseif ($error_data[0] == 'email')                     $this->add_error('Not valid email', array('param' => $field));
					elseif ($error_data[0] == 'strtotime')                 $this->add_error('Invalid format',  array('param' => $field));
					elseif ($error_data[0] == 'Trip::validate_phone')      $this->add_error('Invalid format',  array('param' => $field));
					elseif ($error_data[0] == 'Googlemaps::valid_address')
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
						else
						{
							$this->add_error('Invalid address', array('param' => $field));
						}
					}
				}
			}

			$googlemaps = Googlemaps::instance();
		}
		else
		{
			$this->add_error('Required', array('param' => 'from'));
			$this->add_error('Required', array('param' => 'to'));
			$this->add_error('Required', array('param' => 'when'));
			$this->add_error('Required', array('param' => 'name'));
			$this->add_error('Required', array('param' => 'email'));
			$this->add_error('Required', array('param' => 'phone'));
		}
	}

}
