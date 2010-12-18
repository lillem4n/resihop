<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:include href="tpl.template.xsl" />

	<xsl:template name="title">Samåkning på enkelt vis. Gör naturen och din plånbok en tjänst, Res Ihop!</xsl:template>
	<xsl:template name="goal">
	<xsl:choose>
		<xsl:when test="/root/content/new_trip/*">
			<xsl:text>_gaq.push(['_trackPageview', '/added_trip/done']);</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>_gaq.push(['_trackPageview', '/added_trip/try']);</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
	</xsl:template>

	<xsl:template name="description">Hitta människor för samåkning, ingen registrering, inget krångel! Det är bara att lägga upp resan som passagerare eller förare.</xsl:template>

	<xsl:template match="/">
		<xsl:call-template name="base" />
	</xsl:template>

	<xsl:template match="/root/content">
		<xsl:choose>

			<!-- Trip is saved -->
			<xsl:when test="/root/content/new_trip/*">
				<xsl:if test="/root/meta/url_params/got_car = 1">
					<xsl:call-template name="trip_saved">
						<xsl:with-param name="type" select="'driver'" />
						<xsl:with-param name="header" select="'Din resa är sparad'" />
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="/root/meta/url_params/got_car = 0">
					<xsl:call-template name="trip_saved">
						<xsl:with-param name="type" select="'passenger'" />
						<xsl:with-param name="header" select="'Din resa är sparad'" />
					</xsl:call-template>
				</xsl:if>
			</xsl:when>

			<!-- Trying to add a trip -->
			<xsl:otherwise>
				<xsl:if test="/root/meta/url_params/got_car = 1">
					<xsl:call-template name="trip_form">
						<xsl:with-param name="type" select="'driver'" />
						<xsl:with-param name="header" select="'Spara din resa'" />
						<xsl:with-param name="function" select="'addtrip'" />
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="/root/meta/url_params/got_car = 0">
					<xsl:call-template name="trip_form">
						<xsl:with-param name="type" select="'passenger'" />
						<xsl:with-param name="header" select="'Spara din resa'" />
						<xsl:with-param name="function" select="'addtrip'" />
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="/root/meta/url_params/got_car = '' or not(/root/meta/url_params/got_car)">
					<xsl:call-template name="trip_form">
						<xsl:with-param name="type" select="''" />
						<xsl:with-param name="header" select="'Spara din resa'" />
						<xsl:with-param name="function" select="'addtrip'" />
					</xsl:call-template>
				</xsl:if>
			</xsl:otherwise>

		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
