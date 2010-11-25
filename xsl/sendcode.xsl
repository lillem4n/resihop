<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:include href="tpl.template.xsl" />

	<xsl:template name="title">Samåkning på enkelt vis. Gör naturen och din plånbok en tjänst, Res Ihop!</xsl:template>

	<xsl:template match="/">
		<xsl:call-template name="base" />
	</xsl:template>

	<xsl:template match="/root/content">
		<xsl:choose>
			<xsl:when test="/root/content/message = 'Code sent'">
				<xsl:call-template name="message_box">
					<xsl:with-param name="title" select="'Kod skickad'" />
					<xsl:with-param name="message" select="'Koden för att ändra din resa är nu skickad till den angivna e-post-adressen. Kolla i spam-filtret ifall mailet inte kommer fram.'" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="/root/meta/path = 'sendcode' and not(/root/content/message)">
				<xsl:call-template name="sendcode_form" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="edit_form" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
