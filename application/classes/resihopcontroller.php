<?php defined('SYSPATH') OR die('No direct access allowed.');

class Resihopcontroller extends Xsltcontroller
{

	public function __construct()
	{
		parent::__construct();

		// We accept URL params to, for the API
		if (count($_GET))
		{
			foreach ($_GET as $key => $value)
			{
				$_POST[$key] = urldecode($value);
			}
		}

		xml::to_XML(
			array('url_params' => $_POST),
			$this->xml_meta
		);

		xml::to_XML(
			array('version' => Kohana::config('resihop.version')),
			$this->xml_meta
		);
	}

	public function add_error($error_message, $additional_data = array())
	{

		if (!isset($this->xml_content_errors))
		{
			$this->xml_content_errors = $this->xml_meta->appendChild($this->dom->createElement('errors'));
			$this->errors             = array();
		}

		$this->errors[] = array(
			'message' => $error_message,
			'data'    => $additional_data,
		);

		xml::to_XML(
			array(
				'error' => array(
					'message' => $error_message,
					'data'    => $additional_data,
				),
			),
			$this->xml_content_errors
		);
	}

}
