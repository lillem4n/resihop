<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:include href="tpl.template.xsl" />

	<xsl:template name="title">Samåkning på enkelt vis. Gör naturen och din plånbok en tjänst, Res Ihop!</xsl:template>

	<xsl:template name="description">Hitta människor för samåkning, ingen registrering, inget krångel! Det är bara att lägga upp resan som passagerare eller förare.</xsl:template>

	<xsl:template match="/">
		<xsl:call-template name="base" />
	</xsl:template>

	<xsl:template match="/root/content">
		<xsl:choose>
			<xsl:when test="/root/content/message = 'Trip removed'">
				<xsl:call-template name="message_box">
					<xsl:with-param name="title" select="'Resan är borttagen'" />
					<xsl:with-param name="message" select="'Resan är nu borttagen, använd gärna tyck-till-knappen till höger om du har några klagomål!'" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="/root/meta/errors/error/data/param = 'code'">
				<xsl:call-template name="edit_form" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="/root/content/trip_data/got_car = 1 or /root/meta/url_params/got_car = 1">
					<xsl:call-template name="trip_form">
						<xsl:with-param name="type" select="'driver'" />
						<xsl:with-param name="header" select="'Ändra eller ta bort din resa'" />
						<xsl:with-param name="function" select="'edittrip'" />
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="/root/content/trip_data/got_car = 0 or /root/meta/url_params/got_car = 0">
					<xsl:call-template name="trip_form">
						<xsl:with-param name="type" select="'passenger'" />
						<xsl:with-param name="header" select="'Ändra eller ta bort din resa'" />
						<xsl:with-param name="function" select="'edittrip'" />
					</xsl:call-template>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
