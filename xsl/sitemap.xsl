<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

		<xsl:template match="/" name="sitemap">
			<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
				<!--Root-->
				<url><loc><xsl:value-of select="/root/meta/protocol" /><xsl:text>://</xsl:text><xsl:value-of select="/root/meta/domain" />
</loc><changefreq>monthly</changefreq><priority>1</priority></url>
				<url><loc><xsl:value-of select="/root/meta/protocol" /><xsl:text>://</xsl:text><xsl:value-of select="/root/meta/domain" /></loc><changefreq>monthly</changefreq><priority>1</priority></url>
				
				<!--Q-->
				<xsl:for-each select="/root/content/trips/trip">
					<url>
						<loc>
							<xsl:value-of select="/root/meta/protocol" />
							<xsl:text>://</xsl:text>
							<xsl:value-of select="/root/meta/domain" />
							<xsl:text>/search?q=</xsl:text>
							<xsl:value-of select="from"/>
						</loc>
						<changefreq>daily</changefreq>
						<priority>0.7</priority>
					</url>
				</xsl:for-each>
				<xsl:for-each select="/root/content/trips/trip">
					<url>
						<loc>
							<xsl:value-of select="/root/meta/protocol" />
							<xsl:text>://</xsl:text>
							<xsl:value-of select="/root/meta/domain" />
							<xsl:text>/search?q=</xsl:text>
							<xsl:value-of select="to"/>
						</loc>
						<changefreq>daily</changefreq>
						<priority>0.7</priority>
					</url>
				</xsl:for-each>

				<!--From-->
				<xsl:for-each select="/root/content/trips/trip">
					<url>
						<loc>
							<xsl:value-of select="/root/meta/protocol" />
							<xsl:text>://</xsl:text>
							<xsl:value-of select="/root/meta/domain" />
							<xsl:text>/search?from=</xsl:text>
							<xsl:value-of select="from"/>
						</loc>
						<changefreq>daily</changefreq>
						<priority>0.5</priority>
					</url>
				</xsl:for-each>

				<!--To-->
				<xsl:for-each select="/root/content/trips/trip">
					<url>
						<loc>
							<xsl:value-of select="/root/meta/protocol" />
							<xsl:text>://</xsl:text>
							<xsl:value-of select="/root/meta/domain" />
							<xsl:text>/search?&amp;to=</xsl:text>
							<xsl:value-of select="to"/>
						</loc>
						<changefreq>daily</changefreq>
						<priority>0.5</priority>
					</url>
				</xsl:for-each>

				<!--From and to-->
				<xsl:for-each select="/root/content/trips/trip">
					<url>
						<loc>
							<xsl:value-of select="/root/meta/protocol" />
							<xsl:text>://</xsl:text>
							<xsl:value-of select="/root/meta/domain" />
							<xsl:text>/search?from=</xsl:text>
							<xsl:value-of select="from"/>
							<xsl:text>&amp;to=</xsl:text>
							<xsl:value-of select="to"/>
						</loc>
						<changefreq>daily</changefreq>
						<priority>0.3</priority>
					</url>
				</xsl:for-each>

			</urlset>
		</xsl:template>

</xsl:stylesheet>
