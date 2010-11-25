<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="tpl.template.xsl" />

	<xsl:template name="title">Samåkning på enkelt vis. Gör naturen och din plånbok en tjänst, Res Ihop!</xsl:template>

	<xsl:template match="/">
		<xsl:call-template name="base" />
	</xsl:template>

	<xsl:template match="/root/content">
		<xsl:choose>
			<xsl:when test="count(/root/content/trips/trip) = 0">
				<xsl:choose>
					<xsl:when test="/root/content/new_trip/*">
						<xsl:call-template name="trip_saved">
							<xsl:with-param name="header" select="'Din resa är sparad'" />
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="trip_form">
							<xsl:with-param name="header" select="'Spara din resa'" />
							<xsl:with-param name="size" select="'savetrip'" />
							<xsl:with-param name="function" select="'addtrip'" />
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
			<xsl:if test="/root/meta/url_params/got_car = 0">
				<xsl:call-template name="message" />
				<xsl:call-template name="trip_form" />
			</xsl:if>
			<xsl:if test="not(/root/meta/url_params/got_car = 0)">
				<xsl:call-template name="trip_form" />
				<xsl:call-template name="message" />
			</xsl:if>
			<xsl:call-template name="searchresults" />
			<xsl:call-template name="logo" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


</xsl:stylesheet>
