<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_Welcome extends Resihopcontroller {

	public function action_index()
	{
		// Set the name of the template to use
		$this->xslt_stylesheet = 'welcome';
	}

}
