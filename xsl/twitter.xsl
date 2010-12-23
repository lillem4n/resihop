<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:atom="http://www.w3.org/2005/Atom" >


		<xsl:template match="/" name="twitter">
			<rss version="2.0">
			<channel>
				<title>
					<xsl:value-of select="'Resihop tweet - Samåkning '" />
						<xsl:if test="/root/meta/url_params/q and not(/root/meta/url_params/q = '')" >
							<xsl:value-of select="' till eller från '" />
							<xsl:value-of select="/root/meta/url_params/q" />
						</xsl:if>
						<xsl:if test="/root/meta/url_params/from and not(/root/meta/url_params/from = '')" >
							<xsl:value-of select="' från '" />
							<xsl:if test="substring(to,string-length(from) - 7,8) = ', Sweden'">
								<xsl:value-of select="substring(from, 0, string-length(from) - 7)" />
							</xsl:if>
							<xsl:if test="substring(to,string-length(from) - 7,8) != ', Sweden'">
								<xsl:value-of select="from"/>
							</xsl:if>						</xsl:if>
						<xsl:if test="/root/meta/url_params/to and not(/root/meta/url_params/to = '')" >
							<xsl:value-of select="' till '" />
							<xsl:if test="substring(to,string-length(to) - 7,8) = ', Sweden'">
								<xsl:value-of select="substring(to, 0, string-length(to) - 7)" />
							</xsl:if>
							<xsl:if test="substring(to,string-length(to) - 7,8) != ', Sweden'">
								<xsl:value-of select="to"/>
							</xsl:if>
						</xsl:if>
						<xsl:if test="/root/meta/url_params/when and not(/root/meta/url_params/when = '')" >
							<xsl:value-of select="' den '" />
							<xsl:value-of select="substring(/root/meta/url_params/when, 0, 10)" />
						</xsl:if>
						<xsl:if test="/root/meta/url_params/got_car = '1'" >
							<xsl:value-of select="' med bil.'" />
						</xsl:if>
						<xsl:if test="/root/meta/url_params/got_car = '0'" >
							<xsl:value-of select="' som söker bil.'" />
						</xsl:if>
				</title>
				<description>
					Tweets för samåkningar från resihop.nu
				</description>
				<language>sv-se</language>
				<link>
					<xsl:value-of select="/root/meta/protocol" />
					<xsl:value-of select="'://'" />
					<xsl:value-of select="/root/meta/domain" />
					<xsl:value-of select="/root/meta/base" />
					<xsl:value-of select="'search?'" />
					<xsl:for-each select="/root/meta/url_params/*">
						<xsl:value-of select="name(.)" />
						<xsl:text>=</xsl:text>
						<xsl:value-of select="." />
						<xsl:text>&#160;</xsl:text>
					</xsl:for-each>
				</link>
				<atom:link rel="self" type="application/rss+xml">
					<xsl:attribute name="href">
						<xsl:value-of select="/root/meta/protocol" />
						<xsl:value-of select="'://'" />
						<xsl:value-of select="/root/meta/domain" />
						<xsl:value-of select="/root/meta/base" />
						<xsl:value-of select="'twitter?'" />
						<xsl:for-each select="/root/meta/url_params/*">
							<xsl:value-of select="name(.)" />
							<xsl:text>=</xsl:text>
							<xsl:value-of select="." />
							<xsl:text>&#160;</xsl:text>
						</xsl:for-each>
					</xsl:attribute>
				</atom:link>
				<image>
					<url>http://reishop.nu/images/bluegreen.png</url>
  					<title>Res ihop!</title>
    				<link>
    					<xsl:value-of select="/root/meta/protocol" />
						<xsl:value-of select="'://'" />
						<xsl:value-of select="/root/meta/domain" />
						<xsl:value-of select="/root/meta/base" />
    				</link>
				</image>
				<!--From and to-->
				<xsl:for-each select="/root/content/trips/trip">
			      <xsl:sort select="inserted" data-type="number"/>
					<item>
						<title>
							<xsl:if test="got_car = '1'" >
								<xsl:value-of select="'Söker passagerare '" />
							</xsl:if>
							<xsl:if test="got_car = '0'" >
								<xsl:value-of select="'Söker bil '" />
							</xsl:if>
							<xsl:text>#</xsl:text>
								<xsl:if test="substring(from,string-length(from) - 7,8) = ', Sweden'">
									<xsl:value-of select="substring(substring(from, 0, string-length(from) - 7), 0, 28)" />
								</xsl:if>
								<xsl:if test="substring(from,string-length(from) - 7,8) != ', Sweden'">
									<xsl:value-of select="substring(from, 0, 28)"/>
								</xsl:if>
							<xsl:text>-> #</xsl:text>
								<xsl:if test="substring(to,string-length(to) - 7,8) = ', Sweden'">
									<xsl:value-of select="substring(substring(to, 0, string-length(to) - 7), 0, 28)" />
								</xsl:if>
								<xsl:if test="substring(to,string-length(to) - 7,8) != ', Sweden'">
									<xsl:value-of select="substring(to, 0, 28)"/>
								</xsl:if>
							<xsl:text> </xsl:text>
							<xsl:value-of select="substring(when_iso, 0, 10)"/>
							<xsl:text> #samåkning.</xsl:text>
						</title>
						<link>
							<xsl:value-of select="/root/meta/protocol" />
							<xsl:value-of select="'://'" />
							<xsl:value-of select="/root/meta/domain" />
							<xsl:value-of select="/root/meta/base" />
							<xsl:value-of select="'search?from='" />
							<xsl:value-of select="from" />
							<xsl:value-of select="'to='" />
							<xsl:value-of select="to" />
							<xsl:value-of select="'got_car='" />
							<xsl:value-of select="got_car" />
						</link>
						<guid>
							<xsl:text>resihop:</xsl:text>
							<xsl:value-of select="trip_id"/>
						</guid>
					</item>
				</xsl:for-each>
			</channel>
		</rss>
		</xsl:template>

</xsl:stylesheet>