<?php defined('SYSPATH') or die('No direct script access.');

/*
IMPORTANT! Add this line to your bootstrap when you go live:
Kohana::$environment = Kohana::PRODUCTION;
And have it commented out while developing.
*/

return array(
//	'driver' => 'mysql',
	'driver'        => Kohana::config('pdo.default.driver'),
	'root_password' => FALSE,
);
