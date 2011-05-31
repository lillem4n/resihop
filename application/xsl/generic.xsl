<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output
	method="html"
	encoding="utf-8"
	doctype-system="about:legacy-compat"
	indent="no"
	omit-xml-declaration="no"
/>

	<xsl:include href="tpl.template.xsl" />
	<xsl:include href="inc.elements.xsl" />

	<xsl:template name="title">Samåkning på enkelt vis. Gör naturen och din plånbok en tjänst, Res Ihop!</xsl:template>
	<xsl:template name="goal" />

	<xsl:template name="description">Hitta människor för samåkning, ingen registrering, inget krångel! Det är bara att lägga upp resan som passagerare eller förare.</xsl:template>

	<xsl:template match="/">
		<xsl:call-template name="base" />
	</xsl:template>

	<xsl:template match="/root/content">
		<div class="freetext">
			<xsl:call-template name="load_content">
				<xsl:with-param name="field_id" select="'1'" />
			</xsl:call-template>

			<xsl:if test="/root/meta/path = 'about'">
				<img src="/images/eu.gif" alt="GD Utbildning och kultur" />
				<p style="font-family: 'Tahoma';">Projektet genomförs med ekonomiskt stöd från Europeiska kommissionen. För uppgifterna i denna publikation (meddelande) ansvarar endast upphovsmannen. Europeiska kommissionen tar inget ansvar för hur dessa uppgifter kan komma att användas.</p>
			</xsl:if>
		</div>
	</xsl:template>

</xsl:stylesheet>
