<?php defined('SYSPATH') or die('No direct access allowed.');

return array
(
	/**
	 * MySQL as default example
	 * This connection will be used in the model and
	 * all places where no special connection is defined
	 */
	'default' => array
	(
		'driver'        => 'mysql',
		'hostname'      => 'localhost',
		'database_name' => 'foobar',
		'username'      => 'user',
		'password'      => 'pass',
	),

	// SQLite example
	'files' => array
	(
		'driver'        => 'sqlite',
		'database_name' => '/var/sqlite.db',
	),

	/**
	 * Different PDO connection strings. As you might guess, these are
	 * mapped from the "driver" option above. The strings within {} are
	 * replaced with the values configured above. See
	 * http://php.net/manual/en/pdo.drivers.php for more information.
	 */
	'connection_strings' => array(
		'pgsql'    => 'pgsql:dbname={database_name};host={hostname}',
		'mysql'    => 'mysql:dbname={database_name};host={hostname}',
		'sqlite'   => 'sqlite:{database_name}', // Database name should be the full path to the database file, or ":memory"
	),
);
