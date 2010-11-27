-- phpMyAdmin SQL Dump
-- version 3.3.0
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 27, 2010 at 01:56 AM
-- Server version: 5.1.37
-- PHP Version: 5.2.10-2ubuntu6.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `resihop`
--

-- --------------------------------------------------------

--
-- Table structure for table `google_cache`
--

CREATE TABLE IF NOT EXISTS `google_cache` (
  `lon` float(7,4) DEFAULT NULL,
  `lat` float(7,4) DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_swedish_ci NOT NULL,
  `search_string` varchar(255) COLLATE utf8_swedish_ci NOT NULL,
  `manually_added` int(1) unsigned NOT NULL,
  PRIMARY KEY (`search_string`),
  KEY `address` (`address`),
  KEY `lon` (`lon`,`lat`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `google_cache_multiple_locations`
--

CREATE TABLE IF NOT EXISTS `google_cache_multiple_locations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `search_string` varchar(255) COLLATE utf8_swedish_ci NOT NULL,
  `address` varchar(255) COLLATE utf8_swedish_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `search_string` (`search_string`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `spam_check`
--

CREATE TABLE IF NOT EXISTS `spam_check` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ip` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `when` int(13) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trips`
--

CREATE TABLE IF NOT EXISTS `trips` (
  `trip_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_lon` float(7,4) NOT NULL,
  `from_lat` float(7,4) NOT NULL,
  `to_lon` float(7,4) NOT NULL,
  `to_lat` float(7,4) NOT NULL,
  `when` int(13) NOT NULL,
  `got_car` tinyint(1) NOT NULL,
  `details` text COLLATE utf8_swedish_ci NOT NULL,
  `inserted` int(13) NOT NULL,
  `name` varchar(255) COLLATE utf8_swedish_ci NOT NULL DEFAULT '',
  `email` varchar(255) COLLATE utf8_swedish_ci NOT NULL DEFAULT '',
  `phone` varchar(255) COLLATE utf8_swedish_ci NOT NULL DEFAULT '',
  `code` varchar(20) COLLATE utf8_swedish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`trip_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

