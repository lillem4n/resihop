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
	}

}
