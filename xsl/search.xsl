<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="tpl.template.xsl" />

	<xsl:template name="title">
		<xsl:value-of select="'Samåkningar '" />
		<xsl:if test="/root/meta/url_params/q and not(/root/meta/url_params/q = '')" >
			<xsl:value-of select="' till eller från '" />
			<xsl:value-of select="/root/meta/url_params/q" />
		</xsl:if>
		<xsl:if test="/root/meta/url_params/from and not(/root/meta/url_params/from = '')" >
			<xsl:value-of select="' från '" />
			<xsl:value-of select="/root/meta/url_params/from" />
		</xsl:if>
		<xsl:if test="/root/meta/url_params/to and not(/root/meta/url_params/to = '')" >
			<xsl:value-of select="' till '" />
			<xsl:value-of select="/root/meta/url_params/to" />
		</xsl:if>
		<xsl:if test="/root/meta/url_params/when and not(/root/meta/url_params/when = '')" >
			<xsl:value-of select="' den '" />
			<xsl:value-of select="/root/meta/url_params/when" />
		</xsl:if>
	</xsl:template>

	<xsl:template name="description">
		<xsl:value-of select="'Alla våra resor'" />
		<xsl:if test="/root/meta/url_params/q and not(/root/meta/url_params/q = '')" >
			<xsl:value-of select="' till eller från '" />
			<xsl:value-of select="/root/meta/url_params/q" />
		</xsl:if>
		<xsl:if test="/root/meta/url_params/from and not(/root/meta/url_params/from = '')" >
			<xsl:value-of select="' från '" />
			<xsl:value-of select="/root/meta/url_params/from" />
		</xsl:if>
		<xsl:if test="/root/meta/url_params/to and not(/root/meta/url_params/to = '')" >
			<xsl:value-of select="' till '" />
			<xsl:value-of select="/root/meta/url_params/to" />
		</xsl:if>
		<xsl:if test="/root/meta/url_params/when and not(/root/meta/url_params/when = '')" >
			<xsl:value-of select="' den '" />
			<xsl:value-of select="/root/meta/url_params/when" />
		</xsl:if>
	</xsl:template>

	<xsl:template match="/">
		<xsl:call-template name="base" />
	</xsl:template>

	<xsl:template match="/root/content">
		<xsl:choose>

			<!-- Inga träffar så vi visar spara resa istället -->
			<xsl:when test="count(/root/content/trips/trip) = 0 and not(/root/meta/errors)">

				<xsl:if test="/root/meta/url_params/got_car = 0">
					<xsl:call-template name="trip_form">
						<xsl:with-param name="header"   select="'Ingen resa matchade din sökning - Spara din resa'" />
						<xsl:with-param name="size"     select="'savetrip'" />
						<xsl:with-param name="function" select="'addtrip'" />

						<!-- Since you search for got_car 0, you're a driver -->
						<xsl:with-param name="type" select="'driver'" />

					</xsl:call-template>
				</xsl:if>

				<xsl:if test="/root/meta/url_params/got_car = 1">
					<xsl:call-template name="trip_form">
						<xsl:with-param name="header"   select="'Ingen resa matchade din sökning - Spara din resa'" />
						<xsl:with-param name="size"     select="'savetrip'" />
						<xsl:with-param name="function" select="'addtrip'" />

						<!-- Since you search for got_car 1, you're a passenger -->
						<xsl:with-param name="type" select="'passenger'" />

					</xsl:call-template>
				</xsl:if>

			</xsl:when>

			<xsl:otherwise>

				<xsl:if test="/root/meta/url_params/got_car = 0">
					<xsl:call-template name="message">
						<xsl:with-param name="type" select="'driver'" />
					</xsl:call-template>

					<xsl:call-template name="logo">
						<xsl:with-param name="type" select="'driver'" />
					</xsl:call-template>

					<xsl:call-template name="trip_form">
						<xsl:with-param name="header" select="'Jag söker passagerare'" />
						<xsl:with-param name="type" select="'driver'" />
						<xsl:with-param name="size" select="'search'" />
						<xsl:with-param name="function" select="'search'" />
					</xsl:call-template>

					<xsl:call-template name="searchresults">
						<xsl:with-param name="type" select="'driver'" />
					</xsl:call-template>
				</xsl:if>

				<xsl:if test="/root/meta/url_params/got_car = 1">
					<xsl:call-template name="trip_form">
						<xsl:with-param name="header" select="'Jag söker skjuts'" />
						<xsl:with-param name="type" select="'passenger'" />
						<xsl:with-param name="size" select="'search'" />
						<xsl:with-param name="function" select="'search'" />
					</xsl:call-template>

					<xsl:call-template name="logo">
						<xsl:with-param name="type" select="'passenger'" />
					</xsl:call-template>

					<xsl:call-template name="message">
						<xsl:with-param name="type" select="'passenger'" />
					</xsl:call-template>

					<xsl:call-template name="searchresults">
						<xsl:with-param name="type" select="'passenger'" />
					</xsl:call-template>
				</xsl:if>

				<xsl:if test="/root/meta/url_params/got_car = '' or not(/root/meta/url_params/got_car)">
					<xsl:call-template name="trip_form">
						<xsl:with-param name="header" select="'Specificera din sökning'" />
						<xsl:with-param name="size" select="'search'" />
						<xsl:with-param name="function" select="'search'" />
						<xsl:with-param name="type" select="''" />
					</xsl:call-template>

					<xsl:call-template name="logo">
						<xsl:with-param name="type" select="''" />
					</xsl:call-template>

					<xsl:call-template name="message">
						<xsl:with-param name="type" select="''" />
					</xsl:call-template>

					<xsl:call-template name="searchresults">
						<xsl:with-param name="type" select="''" />
					</xsl:call-template>

				</xsl:if>

			</xsl:otherwise>

		</xsl:choose>

	</xsl:template>


</xsl:stylesheet>
