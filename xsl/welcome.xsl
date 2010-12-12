<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:include href="tpl.template.xsl" />

	<xsl:template name="title">Ett miljövänligt och billigt sätt att resa - Samåkning</xsl:template>

	<xsl:template name="description">Hitta människor för samåkning, ingen registrering, inget krångel! Det är bara att lägga upp resan som passagerare eller förare.</xsl:template>

	<xsl:template match="/">
		<xsl:call-template name="base" />
	</xsl:template>

	<xsl:template match="/root/content">
		<xsl:call-template name="trip_form">
			<xsl:with-param name="header" select="'Jag söker skjuts'" />
			<xsl:with-param name="type" select="'driver'" />
			<xsl:with-param name="size" select="'search'" />
			<xsl:with-param name="function" select="'search'" />
		</xsl:call-template>
		
		<xsl:call-template name="logo" />
		
		<xsl:call-template name="trip_form">
			<xsl:with-param name="header" select="'Jag söker passagerare'" />
			<xsl:with-param name="type" select="'passenger'" />
			<xsl:with-param name="size" select="'search'" />
			<xsl:with-param name="function" select="'search'" />
		</xsl:call-template>
	</xsl:template>

</xsl:stylesheet>
