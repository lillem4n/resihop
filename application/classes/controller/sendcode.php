<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Sendcode extends Resihopcontroller
{

	public function __construct()
	{
		// This is needed for the XSLT setup
		parent::__construct();
	}

	public function action_index()
	{
		// Set the name of the template to use
		$this->xslt_stylesheet = 'sendcode';

		if (isset($_POST['email']) && $_POST['email'] != '')
		{
			$post = new Validate($_POST);
			$post->filter(TRUE, 'trim');

			$trip_ids = Trip::get_trip_ids_by_email($post['email']);
			$sent     = FALSE;
			foreach ($trip_ids as $trip_id)
			{
				$trip = new Trip($trip_id);
				if ($trip->when > time())
				{
				  $sent = TRUE;
					if (isset($_POST['locale'])) $trip->email_code($_POST['locale']);
					else                         $trip->email_code('sv_SE');
				}
			}
			if ($sent == FALSE) $this->add_error('Invalid', array('param' => 'email'));
			else                xml::to_XML(array('message' => 'Code sent'), $this->xml_content);
		}
		else $this->add_error('Required', array('param' => 'email'));


	}

}
