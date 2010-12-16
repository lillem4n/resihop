<?php defined('SYSPATH') OR die('No direct access allowed.');

class Controller_sitemap extends Resihopcontroller
{

	public function __construct()
	{
		// This is needed for the XSLT setup
		parent::__construct();
		$this->transform = TRUE;
	}

	public function action_index()
	{
		// Set the name of the template to use
		$this->xslt_stylesheet = 'sitemap';

		$trips_node = $this->xml_content->appendChild($this->dom->createElement('trips'));

		if (count($_GET))
		{
			$googlemaps = Googlemaps::instance();

			$get = new Validate($_GET);
			$get->filter(TRUE,     'trim');
			$get->filter(TRUE,     'urldecode');

			$googlemaps = Googlemaps::instance();
		}
		else
		{
			xml::to_XML(Trip::get_trips(), $trips_node, 'trip');
		}
	}

}