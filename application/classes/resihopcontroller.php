<?php defined('SYSPATH') OR die('No direct access allowed.');

class Resihopcontroller extends Xsltcontroller
{

	public function __construct(Request $request, Response $response)
	{
		parent::__construct($request, $response);

		// We accept URL params to, for the API
		if (count($_GET))
		{
			foreach ($_GET as $key => $value)
			{
				$_POST[$key] = urldecode($value);
			}
		}

		// Add all GET/POST data to the XML
		xml::to_XML(
			array('url_params' => $_POST),
			$this->xml_meta
		);

		// Set resihop version, so frontend knows what to expect
		xml::to_XML(
			array('version' => Kohana::config('resihop.version')),
			$this->xml_meta
		);

		// Add the servers current timestamp
		xml::to_XML(
			array('current_timestamp' => time()),
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
