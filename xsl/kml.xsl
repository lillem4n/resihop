<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

		<xsl:template match="/" name="sitemap">
			<kml xmlns="http://www.opengis.net/kml/2.2">
				<Document>
					<name>Alla resor</name>
				    <description>Resor från resihop.</description>	
						<xsl:for-each select="/root/content/trips/trip">
			        <Placemark>
						<name>
							<xsl:text>Från </xsl:text>
							<xsl:value-of select="from"/>
							<xsl:text> till </xsl:text>
							<xsl:value-of select="to"/>
							<xsl:text> den </xsl:text>
							<xsl:value-of select="when_iso"/>
						</name>
						<description>
							<xsl:value-of select="details"/>
							<xsl:text> </xsl:text>
							<xsl:value-of select="name"/>
							<xsl:text> </xsl:text>
							<xsl:value-of select="phone"/>
						</description>
						<LineString>
							<coordinates>
								<xsl:value-of select="from_lat"/>
								<xsl:text>,</xsl:text>
								<xsl:value-of select="from_lon"/>
								<xsl:text> </xsl:text>
								<xsl:value-of select="to_lat"/>
								<xsl:text>,</xsl:text>
								<xsl:value-of select="to_lon"/>
							</coordinates>
						</LineString>
				    </Placemark>
					</xsl:for-each>
						
				</Document>

			</kml>
		</xsl:template>

</xsl:stylesheet>