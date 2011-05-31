<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:atom="http://www.w3.org/2005/Atom" >
<xsl:output method="xml" indent="yes"
 doctype-system="http://www.silmaril.ie/software/rss2.dtd"
 doctype-public="-//Netscape Communications//DTD RSS 0.91//EN"/>
 
	<xsl:include href="tpl.template.xsl" />

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
							<xsl:call-template name="place_cleaner">
								<xsl:with-param name="place"   select="from" />
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="/root/meta/url_params/to and not(/root/meta/url_params/to = '')" >
							<xsl:value-of select="' till '" />
									<xsl:call-template name="place_cleaner">
										<xsl:with-param name="place"   select="to" />
									</xsl:call-template>
							</xsl:if>
						<xsl:if test="/root/meta/url_params/when and not(/root/meta/url_params/when = '')" >
							<xsl:value-of select="' den '" />
							<xsl:value-of select="substring(/root/meta/url_params/when, 0, 11)" />
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
			      <xsl:sort select="inserted" order="descending" data-type="number"/>
					<item>
						<title>
							<xsl:if test="got_car = '1'" >
								<xsl:value-of select="'Kommer köra '" />
							</xsl:if>
							<xsl:if test="got_car = '0'" >
								<xsl:value-of select="'Letar bil '" />
							</xsl:if>
							<xsl:text>#</xsl:text>
								<xsl:call-template name="place_cleaner">
									<xsl:with-param name="place"   select="from" />
								</xsl:call-template>
							<xsl:text> - #</xsl:text>
									<xsl:call-template name="place_cleaner">
										<xsl:with-param name="place"   select="to" />
									</xsl:call-template>
							<xsl:text> </xsl:text>
							<xsl:choose>
								<xsl:when test="when - /root/meta/current_timestamp &lt; 86400">
									<xsl:text> imorgon</xsl:text>
								</xsl:when>
								<xsl:when test="when - /root/meta/current_timestamp &lt; 172800">
									<xsl:text> i övermorgon</xsl:text>
								</xsl:when>
								<xsl:when test="when - /root/meta/current_timestamp &lt; 432000">
									<xsl:text> på </xsl:text>
									<xsl:call-template name="get_weekday">
										<xsl:with-param name="when"   select="when" />
									</xsl:call-template>
								</xsl:when>
								<xsl:when test="when - /root/meta/current_timestamp &lt; 1036800">
									<xsl:text> nästa </xsl:text>
									<xsl:call-template name="get_weekday">
										<xsl:with-param name="when"   select="when" />
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="substring(when_iso, 9, 1)!=0">
										<xsl:value-of select="substring(when_iso, 9, 1)"/>
									</xsl:if>
									<xsl:value-of select="substring(when_iso, 10, 1)"/>
									<xsl:text>/</xsl:text>
									<xsl:if test="substring(when_iso, 6, 1)!=0">
										<xsl:value-of select="substring(when_iso, 6, 1)"/>
									</xsl:if>
									<xsl:value-of select="substring(when_iso, 7, 1)"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:text>. #samåkning</xsl:text>
						</title>
						<link>
							<xsl:value-of select="/root/meta/protocol" />
							<xsl:value-of select="'://'" />
							<xsl:value-of select="/root/meta/domain" />
							<xsl:value-of select="/root/meta/base" />
							<xsl:value-of select="'search?from='" />
							<xsl:value-of select="from" />
							<![CDATA[&]]>
							<xsl:value-of select="'to='" />
							<xsl:value-of select="to" />
							<![CDATA[&]]>
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