<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

	<xsl:output
		method="html"
		encoding="utf-8"
		doctype-system="about:legacy-compat"
		indent="no"
		omit-xml-declaration="no"
	/>

	<xsl:template name="base">
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="sv" lang="sv">
			<head>
				<meta charset="UTF-8" />
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
				<meta name="description">
					<xsl:attribute name="content">
						<xsl:call-template name="description" />
					</xsl:attribute>
				</meta>
				<link type="text/css" rel="stylesheet" media="all">
					<xsl:attribute name="href">
						<xsl:text>/css/style-</xsl:text>
						<xsl:value-of select="/root/meta/version" />
						<xsl:text>.css</xsl:text>
					</xsl:attribute>
				</link>
				<xsl:if test="/root/meta/controller = 'search'">
					<xsl:if test="/root/meta/url_params/from and not(/root/meta/url_params/from = '') and /root/meta/url_params/to and not(/root/meta/url_params/to = '') and /root/meta/url_params/when and not(/root/meta/url_params/when = '')" >
	
						<link rel="alternate" type="application/rss+xml">
							<xsl:attribute name="href">
								<xsl:value-of select="/root/meta/protocol" />
								<xsl:value-of select="'://'" />
								<xsl:value-of select="/root/meta/domain" />
								<xsl:value-of select="/root/meta/base" />
								<xsl:value-of select="'rss?'" />
								<xsl:for-each select="/root/meta/url_params/*">
									<xsl:value-of select="name(.)" />
									<xsl:text>=</xsl:text>
									<xsl:value-of select="." />
									<xsl:text>&amp;</xsl:text>
								</xsl:for-each>
							</xsl:attribute>
							<xsl:attribute name="title">
								<xsl:value-of select="'Från '" />
								<xsl:value-of select="/root/meta/url_params/from" />
								<xsl:value-of select="' till '" />
								<xsl:value-of select="/root/meta/url_params/to" />
								<xsl:value-of select="', '" />
								<xsl:value-of select="/root/meta/url_params/when" />
								<xsl:if test="/root/meta/url_params/got_car = '0'" >
									<xsl:value-of select="' med bil.'" />
								</xsl:if>
								<xsl:if test="/root/meta/url_params/got_car = '0'" >
									<xsl:value-of select="' som söker bil.'" />
								</xsl:if>
							</xsl:attribute>
						</link>
					</xsl:if>
					
					<xsl:if test="/root/meta/url_params/from and not(/root/meta/url_params/from = '') and /root/meta/url_params/when and not(/root/meta/url_params/when = '')" >
						<link rel="alternate" type="application/rss+xml">
							<xsl:attribute name="href">
								<xsl:value-of select="/root/meta/protocol" />
								<xsl:value-of select="'://'" />
								<xsl:value-of select="/root/meta/domain" />
								<xsl:value-of select="/root/meta/base" />
								<xsl:value-of select="'rss?from='" />
								<xsl:value-of select="/root/meta/url_params/from" />
								<xsl:value-of select="'&amp;when='" />
								<xsl:value-of select="/root/meta/url_params/when" />
								<xsl:value-of select="'&amp;got_car='" />
								<xsl:value-of select="/root/meta/url_params/got_car" />
							</xsl:attribute>
							<xsl:attribute name="title">
								<xsl:value-of select="'Alla resor från '" />
								<xsl:value-of select="/root/meta/url_params/from" />
								<xsl:value-of select="', '" />
								<xsl:value-of select="/root/meta/url_params/when" />
								<xsl:if test="/root/meta/url_params/got_car = '0'" >
									<xsl:value-of select="' med bil.'" />
								</xsl:if>
								<xsl:if test="/root/meta/url_params/got_car = '0'" >
									<xsl:value-of select="' som söker bil.'" />
								</xsl:if>
							</xsl:attribute>
						</link>
					</xsl:if>
					
					<xsl:if test="/root/meta/url_params/from and not(/root/meta/url_params/from = '')" >
						<link rel="alternate" type="application/rss+xml">
							<xsl:attribute name="href">
								<xsl:value-of select="/root/meta/protocol" />
								<xsl:value-of select="'://'" />
								<xsl:value-of select="/root/meta/domain" />
								<xsl:value-of select="/root/meta/base" />
								<xsl:value-of select="'rss?from='" />
								<xsl:value-of select="/root/meta/url_params/from" />
							</xsl:attribute>
							
							<xsl:attribute name="title">
								<xsl:value-of select="'Alla resor från '" />
								<xsl:value-of select="/root/meta/url_params/from" />
							</xsl:attribute>
						</link>
					</xsl:if>
					
					<xsl:if test="/root/meta/url_params/to and not(/root/meta/url_params/to = '')" >
						<link rel="alternate" type="application/rss+xml">
							<xsl:attribute name="href">
								<xsl:value-of select="/root/meta/protocol" />
								<xsl:value-of select="'://'" />
								<xsl:value-of select="/root/meta/domain" />
								<xsl:value-of select="/root/meta/base" />
								<xsl:value-of select="'rss?to='" />
								<xsl:value-of select="/root/meta/url_params/to" />
							</xsl:attribute>
							
							<xsl:attribute name="title">
								<xsl:value-of select="'Alla resor till '" />
								<xsl:value-of select="/root/meta/url_params/to" />
							</xsl:attribute>
						</link>
					</xsl:if>

					<link rel="alternate" type="application/rss+xml" title="Alla resor">
						<xsl:attribute name="href">
							<xsl:value-of select="/root/meta/protocol" />
							<xsl:value-of select="'://'" />
							<xsl:value-of select="/root/meta/domain" />
							<xsl:value-of select="/root/meta/base" />
							<xsl:value-of select="'rss'" />
						</xsl:attribute>
					</link>
				</xsl:if>
				<base href="http://{root/meta/domain}/" />
				<link rel="icon" type="image/png" href="/favicon.png" />
				<link rel="search" type="application/opensearchdescription+xml" href="quicksearch.xml" title="Resihop.nu" />
				<title><xsl:call-template name="title" /></title>

				<script type="text/javascript" src="/js/jquery-1.4.2.min.js"><![CDATA[ // ]]></script>
				<script type="text/javascript" src="/js/ui.geo_autocomplete.js"><![CDATA[ // ]]></script>
				<script type="text/javascript" src="/js/common-2.0.js"><![CDATA[ // ]]></script>
				<script src="http://maps.gstatic.com/intl/sv_se/mapfiles/api-3/3/5/main.js" type="text/javascript"></script>
				<script type="text/javascript">
					var _gaq = _gaq || [];
					_gaq.push(['_setAccount', 'UA-6975218-3']);
					_gaq.push(['_trackPageview']);
					<xsl:call-template name="goal" />


					(function() {
						var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
						ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
						var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
					})();
				</script>
			</head>
			<body>
				<div id="wrapper">
					<div id="header">
						<a class="header" href="/"><h1>resihop</h1></a>
						<ul id="menu">
							<li><a href="/edittrip">Ändra/Ta bort resa</a></li>
							<li><a>
								<xsl:attribute name="href">
									<xsl:text>/addtrip?from=</xsl:text>
									<xsl:value-of select="/root/meta/url_params/from" />
									<xsl:text>&amp;to=</xsl:text>
									<xsl:value-of select="/root/meta/url_params/to" />
									<xsl:text>&amp;name=</xsl:text>
									<xsl:value-of select="/root/meta/url_params/name" />
									<xsl:text>&amp;email=</xsl:text>
									<xsl:value-of select="/root/meta/url_params/email" />
									<xsl:text>&amp;phone=</xsl:text>
									<xsl:value-of select="/root/meta/url_params/phone" />
									<xsl:text>&amp;details=</xsl:text>
									<xsl:value-of select="/root/meta/url_params/details" />
								</xsl:attribute>
								Lägg till resa
								</a></li>
								<li><a href="/">Sök resa</a></li>
						</ul>
						<p class="catchphrase">Samåkning är ett miljövänligt och billigt sätt att resa.</p>
					</div>
					<xsl:apply-templates select="/root/content" />
				</div>
				<div id="footer">
					<ul>
						<li><a href="/about/">Om resihop</a></li>
						<li><a href="/api/">Api</a></li>
						<li><a href="/contact/">Kontakt</a></li>
					</ul>
					<a id="legal" href="http://kopimi.com">Kopimi</a>
				</div>
				<script type="text/javascript">
						var _kundo = _kundo || {};
						_kundo["org"] = "resihop";

						(function() {
								function async_load(){
										var s = document.createElement('script');
										s.type = 'text/javascript';
										s.async = true;
										s.src = ('https:' == document.location.protocol ? 'https://' : 'http://') +
										'static.kundo.se/embed.js';
										var x = document.getElementsByTagName('script')[0];
										x.parentNode.insertBefore(s, x);
								}
								if (window.attachEvent)
										window.attachEvent('onload', async_load);
								else
										window.addEventListener('load', async_load, false);
						})();
				</script>
			</body>
		</html>
	</xsl:template>

	<xsl:template name="trip_form">
		<xsl:param name="type" />
		<xsl:param name="header" />
		<xsl:param name="function" />

		<xsl:variable name="newtype">
			<xsl:if test="/root/content/trip_data/got_car = 0">
				<xsl:value-of select="'passenger'" />
			</xsl:if>
			<xsl:if test="$type != ''">
				<xsl:value-of select="$type" />
			</xsl:if>
		</xsl:variable>

		<form>
			<xsl:attribute name="class">
			<xsl:text>trip </xsl:text>
			<xsl:value-of select="$function" />
			</xsl:attribute>

			<xsl:attribute name="method">
				<xsl:choose>
					<xsl:when test="$function = 'addtrip' or $function = 'edittrip'">post</xsl:when>
					<xsl:otherwise>get</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>

			<xsl:attribute name="action">
				<xsl:choose>
					<!-- @todo förenkla! -->
					<xsl:when test="$function != ''">
						<xsl:value-of select="'/'" />
						<xsl:value-of select="$function" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'/search'" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>

			<fieldset>
				<xsl:attribute name="class">
					<xsl:value-of select="$type" />
					<xsl:if test="$type = '' or not($type)">
						<xsl:text> passenger</xsl:text>
					</xsl:if>
					<xsl:text> </xsl:text>
					<xsl:if test="$function = 'addtrip' or $function = 'edittrip'">savetrip</xsl:if>
					<xsl:if test="$function = 'search'">search</xsl:if>
				</xsl:attribute>
				<h2><xsl:value-of select="$header" /></h2>
				<xsl:if test="$function = 'addtrip' or $function = 'edittrip'">
					<p class="regular">
						<xsl:choose>
							<xsl:when test="$function = 'addtrip'">För att andra ska kunna kontakta dig behöver vi lite mer information.</xsl:when>
							<xsl:when test="$function = 'edittrip' and not(/root/meta/url_params/posted)">Ändra de uppgifter du vill. Låt de andra vara som de är.</xsl:when>
							<xsl:when test="$function = 'edittrip' and /root/meta/url_params/posted">Dina uppgifter är nu ändrade!</xsl:when>
							<xsl:otherwise>Vi hittade <em>inga <xsl:if test="$type = 'passenger'">passagerare</xsl:if><xsl:if test="$type = 'driver'">bilar</xsl:if></em> för din sökning. Ange dina kontaktuppgifter så att andra kan <em>hitta dig</em>.</xsl:otherwise>
						</xsl:choose>
					</p>
				</xsl:if>
				<xsl:if test="$function = 'addtrip' or $function = 'edittrip'">
					<input type="hidden" name="posted" value="" />
				</xsl:if>
				<div class="generals">
					<xsl:call-template name="inputfield">
						<xsl:with-param name="inputid" select="'from'" />
						<xsl:with-param name="inputlabel" select="'Från'" />
						<xsl:with-param name="inputtitle" select="'Ort, gata eller kommun'" />
						<xsl:with-param name="value" select="/root/meta/url_params/from" />
					</xsl:call-template>
					<xsl:call-template name="inputfield">
						<xsl:with-param name="inputid" select="'to'" />
						<xsl:with-param name="inputlabel" select="'Till'" />
						<xsl:with-param name="inputtitle" select="'Ort, gata eller kommun'" />
						<xsl:with-param name="value" select="/root/meta/url_params/to" />
					</xsl:call-template>
					<xsl:call-template name="inputfield">
						<xsl:with-param name="inputid" select="'when'" />
						<xsl:with-param name="inputlabel" select="'När'" />
						<xsl:with-param name="inputtitle" select="'ÅÅÅÅ-MM-DD'" />
						<xsl:with-param name="value" select="/root/meta/url_params/when" />
					</xsl:call-template>
				</div>
				<xsl:if test="$function = 'addtrip' or $function ='edittrip'">
					<div id="contact">
		 				<xsl:call-template name="inputfield">
							<xsl:with-param name="inputid" select="'name'" />
							<xsl:with-param name="inputlabel" select="'Namn'" />
						</xsl:call-template>
						<xsl:call-template name="inputfield">
							<xsl:with-param name="inputid" select="'email'" />
							<xsl:with-param name="inputlabel" select="'E-post'" />
							<xsl:with-param name="inputtitle" select="'Visas ej.'" />

						</xsl:call-template>
						<xsl:call-template name="inputfield">
							<xsl:with-param name="inputid" select="'phone'" />
							<xsl:with-param name="inputlabel" select="'Telefon'" />
						</xsl:call-template>
					</div>
					<div id="details">
						<label class="regular" for="details">Detaljer</label>
						<!-- Störig buggfix för att fixa störig bugg i backend renderingen -->
						<textarea id="details" name="details" class="field" rows="4" cols="10">
							<xsl:choose>
								<xsl:when test="(/root/meta/url_params/details = '' or not(/root/meta/url_params/details)) and not(/root/content/trip_data/details)">
									<xsl:value-of select="' '" />
								</xsl:when>
								<xsl:when test="not(/root/meta/url_params/details) or /root/meta/url_params/details = ''">
									<xsl:value-of select="/root/content/trip_data/details" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="/root/meta/url_params/details" />
								</xsl:otherwise>
							</xsl:choose>
						</textarea>
					</div>
				</xsl:if>
				<div id="radiobuttons">
					<xsl:if test="(/root/meta/controller = 'welcome') or not($type = '')">
						<xsl:attribute name="class">hidden</xsl:attribute>
					</xsl:if>
					<xsl:if test="$function = 'addtrip' or $function = 'edittrip'">
						<input id="car" type="radio" value="0" name="got_car">
							<xsl:if test="$type = 'passenger'">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:if>
						</input>
						<label class="regular" for="car">Jag söker skjuts</label>
						<input id="passenger" type="radio" value="1" name="got_car">
							<xsl:if test="$type = 'driver'">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:if>
						</input>
						<label class="regular" for="passenger">Jag söker passagerare</label>
					</xsl:if>

					<xsl:if test="not($function = 'addtrip' or $function = 'edittrip')">

						<input id="car" type="radio" value="1" name="got_car">
							<xsl:if test="$type = 'passenger'">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:if>
						</input>
						<label class="regular" for="car">Jag söker skjuts</label>
						<input id="passenger" type="radio" value="0" name="got_car">
							<xsl:if test="$type = 'driver'">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:if>
						</input>
						<label class="regular" for="passenger">Jag söker passagerare</label>
					</xsl:if>

				</div>
				<input type="hidden" name="code">
					<xsl:attribute name="value">
						<xsl:value-of select="/root/meta/url_params/code" />
					</xsl:attribute>
				</input>
				<input class="button" type="submit">
					<xsl:attribute name="value">
					<xsl:choose>
						<xsl:when test="$function = 'addtrip'">
							<xsl:value-of select="'Spara resa'" />
						</xsl:when>
						<xsl:when test="$function = 'edittrip'">
							<xsl:value-of select="'Spara ändringar'" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'Sök'" />
						</xsl:otherwise>
					</xsl:choose>
					</xsl:attribute>
				</input>
				<xsl:if test="/root/meta/path = 'edittrip'">
					<a class="button">
						<xsl:attribute name="href">
							<xsl:text>/edittrip?remove&amp;code=</xsl:text>
							<xsl:value-of select="/root/meta/url_params/code" />
						</xsl:attribute>
						<xsl:text>Ta bort resa</xsl:text>
					</a>
				</xsl:if>
			</fieldset>
		</form>		
	</xsl:template>

	<xsl:template name="trip_saved">
		<xsl:param name="header" />
		<xsl:param name="type" />
		<div>
			<xsl:attribute name='class'>
				<xsl:value-of select="$type" />
				<xsl:text> savetrip</xsl:text>
			</xsl:attribute>
			<h2>
				<xsl:value-of select="$header" />
			</h2>
			<div class="saved_trip">
				<p class="regular">Koden nedan kan användas om du vill ändra på din resa framöver, du kan också få den mailad till dig senare.</p>
				<p class="code">
					<xsl:value-of select="/root/meta/url_params/code" />
					<xsl:value-of select="/root/content/new_trip/code" />
				</p>
				<p class="prebutton"><xsl:text>Lägg till</xsl:text>
					<a class="button">
						<xsl:attribute name="href">
							<xsl:text>http://</xsl:text>
							<xsl:value-of select="/root/meta/domain" />
							<xsl:text>/addtrip?from=</xsl:text>
							<xsl:value-of select="/root/meta/url_params/to" />
							<xsl:text>&amp;to=</xsl:text>
							<xsl:value-of select="/root/meta/url_params/from" />
							<xsl:text>&amp;name=</xsl:text>
							<xsl:value-of select="/root/meta/url_params/name" />
							<xsl:text>&amp;email=</xsl:text>
							<xsl:value-of select="/root/meta/url_params/email" />
							<xsl:text>&amp;phone=</xsl:text>
							<xsl:value-of select="/root/meta/url_params/phone" />
							<xsl:text>&amp;details=</xsl:text>
							<xsl:value-of select="/root/meta/url_params/details" />
							<xsl:text>&amp;got_car=</xsl:text>
							<xsl:value-of select="/root/meta/url_params/got_car" />
						</xsl:attribute>
						<xsl:text>Returresa</xsl:text>
					</a>
				</p>
			</div>
			<table>
				<tr>
					<td class="label">
					</td>
					<td class="edit">
						<a>
							<xsl:attribute name="href">
								<xsl:text>http://</xsl:text>
								<xsl:value-of select="/root/meta/domain" />
								<xsl:text>/edittrip?code=</xsl:text>
								<xsl:value-of select="/root/meta/url_params/code" />
								<xsl:value-of select="/root/content/new_trip/code" />
							</xsl:attribute>
							<xsl:text>Ändra</xsl:text>
						</a>
					</td>
				</tr>
				<tr>
					<td class="label">Från</td>
					<td><xsl:value-of select="/root/meta/url_params/from" /></td>
				</tr>
				<tr>
					<td class="label">Till</td>
					<td><xsl:value-of select="/root/meta/url_params/to" /></td>
				</tr>
				<tr>
					<td class="label">När</td>
					<td><xsl:value-of select="/root/meta/url_params/when" /></td>
				</tr>
				<tr>
					<td class="label">Namn</td>
					<td><xsl:value-of select="/root/meta/url_params/name" /></td>
				</tr>
				<tr>
					<td class="label">E-post</td>
					<td><xsl:value-of select="/root/meta/url_params/email" /></td>
				</tr>
				<tr>
					<td class="label">Telefon</td>
					<td><xsl:value-of select="/root/meta/url_params/phone" /></td>
				</tr>
				<tr>
					<td class="label last">Detaljer</td>
					<td class="last"><xsl:value-of select="/root/meta/url_params/details" /></td>
				</tr>
			</table>
		</div>
	</xsl:template>

	<xsl:template name="inputfield">
		<xsl:param name="inputid" />
		<xsl:param name="inputlabel" />
		<xsl:param name="inputtitle" />
		<xsl:param name="value" />

		<label class="regular" for="name">
			<xsl:attribute name="for">
				<xsl:value-of select="$inputid" />
			</xsl:attribute>
			<xsl:value-of select="$inputlabel" />
		</label>

		<input type="text">
			<xsl:attribute name="class">
				<xsl:value-of select="'field'" />
				<xsl:text> </xsl:text>
				<xsl:value-of select="$inputid" />
			</xsl:attribute>
			<xsl:attribute name="id">
				<xsl:value-of select="$inputid" />
			</xsl:attribute>
			<xsl:attribute name="name">
				<xsl:value-of select="$inputid" />
			</xsl:attribute>
			<xsl:attribute name="title">
				<xsl:value-of select="$inputtitle" />
			</xsl:attribute>
			<xsl:attribute name="value">
				<xsl:value-of select="/root/meta/url_params/*[name()=$inputid]"/>
				<xsl:if test="not(/root/meta/url_params/*[name()=$inputid])">
					<xsl:choose>
						<xsl:when test="$inputid = 'when'">
							<xsl:value-of select="/root/content/trip_data/when_iso" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="/root/content/trip_data/*[name()=$inputid]" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</xsl:attribute>
		</input>

		<xsl:if test="/root/meta/errors/error/data/param = $inputid">
			<xsl:for-each select="/root/meta/url_params/*">
				<xsl:if test="name(.) = $inputid and(. !='' or /root/meta/url_params/posted) ">
					<div>
						<xsl:attribute name="class">
							<xsl:value-of select="'spacer'" />
						</xsl:attribute>
						<label>
							<xsl:attribute name="for">
								<xsl:value-of select="name(.)" />
							</xsl:attribute>
							<xsl:attribute name="class">
								<xsl:value-of select="'error '" />
								<xsl:value-of select="name(.)" />
								<!-- lägger till visible på det första felmeddelandet -->
								<xsl:if test="name(.) = 'code'">
									<xsl:value-of select="' visible'" />
								</xsl:if>

								<xsl:if test="name(.) = 'from'">
									<xsl:value-of select="' visible'" />
								</xsl:if>

								<xsl:if test="
										name(.) = 'to' and
										not(/root/meta/errors/error/data/param = 'from')
									">
									<xsl:value-of select="' visible '" />
								</xsl:if>

								<xsl:if test="
										name(.) = 'when' and
										not(/root/meta/errors/error/data/param = 'from') and
										not(/root/meta/errors/error/data/param = 'to')
									">
									<xsl:value-of select="' visible'" />
								</xsl:if>

								<xsl:if test="
										name(.) = 'name' and
										not(/root/meta/errors/error/data/param = 'from') and
										not(/root/meta/errors/error/data/param = 'to') and
										not(/root/meta/errors/error/data/param = 'when')
									">
									<xsl:value-of select="' visible'" />
								</xsl:if>

								<xsl:if test="
										name(.) = 'email' and
										not(/root/meta/errors/error/data/param = 'from') and
										not(/root/meta/errors/error/data/param = 'to') and
										not(/root/meta/errors/error/data/param = 'when') and
										not(/root/meta/errors/error/data/param = 'name')
									">
									<xsl:value-of select="' visible'" />
								</xsl:if>

								<xsl:if test="
										name(.) = 'phone' and
										not(/root/meta/errors/error/data/param = 'from') and
										not(/root/meta/errors/error/data/param = 'to') and
										not(/root/meta/errors/error/data/param = 'when') and
										not(/root/meta/errors/error/data/param = 'name') and
										not(/root/meta/errors/error/data/param = 'email')
									">
									<xsl:value-of select="' visible'" />
								</xsl:if>
							</xsl:attribute>

							<xsl:choose>
								<xsl:when test="/root/meta/errors/error[data/param = $inputid]/message = 'Required'">
									<xsl:choose>
										<xsl:when test="$inputid = 'from'">
											<p>Var åker du ifrån?</p>
										</xsl:when>
										<xsl:when test="$inputid = 'to'">
											<p>Var ska du?</p>
										</xsl:when>
										<xsl:when test="$inputid = 'when'">
											<p>När vill du åka?</p>
										</xsl:when>
										<xsl:when test="$inputid = 'name'">
											<p>Ge oss ett namn. Det behöver inte vara ditt riktiga, get creative!</p>
										</xsl:when>
										<xsl:when test="$inputid = 'email'">
											<p>Ange en e-post-adress. Skriv en riktig, du kan lite på oss :)</p>
										</xsl:when>
										<xsl:when test="$inputid = 'phone'">
											<p>Ge oss ett telefonnummer, så folk kan få tag på dig.</p>
										</xsl:when>
										<xsl:otherwise>
											<p>Skriv något i den här här rutan.</p>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:when test="/root/meta/errors/error[data/param = $inputid]/message = 'Invalid format'">
									<xsl:choose>
										<xsl:when test="$inputid = 'when'">
											<p>Ange ett datum enligt formatet ÅÅÅÅ-MM-DD (Det är en standard, vi gillar standarder!)</p>
										</xsl:when>
										<xsl:when test="$inputid = 'phone'">
											<p>Det där verkar inte vara ett telefonnummer, håll dig till siffror!</p>
										</xsl:when>
									</xsl:choose>
								</xsl:when>
								<xsl:when test="/root/meta/errors/error[data/param = $inputid]/message = 'Must select a time in the future'">
									<p>Du måste ta ett datum i framtiden</p>
								</xsl:when>
								<xsl:when test="/root/meta/errors/error[data/param = $inputid]/message = 'Invalid'">
									<xsl:choose>
										<xsl:when test="$inputid = 'code' and /root/meta/url_params/code = ''">
											<p>Du måste skriva in koden du fick när du registrerade resan.</p>
										</xsl:when>
										<xsl:when test="$inputid = 'code' and /root/meta/url_params/code != ''">
											<p>Koden du angett stämmer inte. Om du glömt din kod kan du klicka på länken för att få den skickad till dig.</p>
										</xsl:when>
										<xsl:when test="$inputid = 'email'">
											<p>Ingen resa hittades med denna e-postadress. Kontrollera stavingen och försök igen.</p>
										</xsl:when>
									</xsl:choose>
								</xsl:when>
								<xsl:when test="/root/meta/errors/error[data/param = $inputid]/message = 'Not valid email'">
									<p>Ange en fungerande e-postadress, så du kan ändra eller ta bort din resa.</p>
								</xsl:when>
								<xsl:when test="/root/meta/errors/error[data/param = $inputid]/message = 'Must be a future timestamp'">
									<p>Du måste ta ett datum i framtiden<a href="http://www.youtube.com/watch?v=H3KCnWdiO1k">Dude, you have no quran</a></p>
								</xsl:when>
								<xsl:when test="/root/meta/errors/error[data/param = $inputid]/message = 'Address is not unique'">
									<p>Vilken adress menar du? Välj i listan!</p>
									<ul>
										<xsl:for-each select="/root/meta/errors/error[data/param = $inputid]/data/option">
											<li>
												<a class="adress">
													<xsl:attribute name="href">
														<xsl:value-of select="/root/meta/path" />
														<xsl:text>?from=</xsl:text>
														<xsl:if test="$inputid = 'from'">
															<xsl:value-of select="." />
															<xsl:text>&amp;to=</xsl:text>
															<xsl:value-of select="/root/meta/url_params/to" />
														</xsl:if>
														<xsl:if test="$inputid = 'to'">
															<xsl:value-of select="/root/meta/url_params/from" />
															<xsl:text>&amp;to=</xsl:text>
															<xsl:value-of select="." />
														</xsl:if>
														<xsl:text>&amp;when=</xsl:text>
														<xsl:value-of select="/root/meta/url_params/when" />
														<xsl:text>&amp;got_car=</xsl:text>
														<xsl:value-of select="/root/meta/url_params/got_car" />
														<xsl:text>&amp;name=</xsl:text>
														<xsl:value-of select="/root/meta/url_params/name" />
														<xsl:text>&amp;email=</xsl:text>
														<xsl:value-of select="/root/meta/url_params/email" />
														<xsl:text>&amp;phone=</xsl:text>
														<xsl:value-of select="/root/meta/url_params/phone" />
														<xsl:text>&amp;details=</xsl:text>
														<xsl:value-of select="/root/meta/url_params/details" />
														<xsl:text>&amp;posted</xsl:text>
													</xsl:attribute>
													<xsl:value-of select="." />
												</a>
											</li>
										</xsl:for-each>
									</ul>
								</xsl:when>
								<xsl:when test="/root/meta/errors/error[data/param = $inputid]/message = 'Invalid address'">
									<p>Den här adressen finns inte. Prova att skriva en annan adress eller namnet på staden du vill åka ifrån</p>
								</xsl:when>
								<xsl:otherwise>
									<p>
										<xsl:value-of select="message" />
										<xsl:for-each select="data/option">
											<xsl:value-of select="." /><br />
										</xsl:for-each>
									</p>
								</xsl:otherwise>
							</xsl:choose>
						</label>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>

	<xsl:template name="logo">
		<xsl:param name="type" />
		<div>
			<xsl:attribute name="class">
				<xsl:text>highfive </xsl:text>
				<xsl:value-of select="$type"/>
				<xsl:if test="($type = '' or not($type)) and /root/meta/url_params/controller != welcome">
					<xsl:text>passenger</xsl:text>
				</xsl:if>
				<xsl:text>highfive</xsl:text>
			</xsl:attribute>
			<xsl:value-of select="' '" />
		</div>
	</xsl:template>
	
	<xsl:template name="show_all">
		<a class="show_all show_all_driver" href="/search?got_car=1">Visa alla som kör bil</a>
		<a class="show_all show_all_passenger" href="/search?got_car=0">Visa alla som vill ha skjuts</a>
	</xsl:template>

	<xsl:template name="edit_form">
		<form class="trip" method="get" action="/edittrip" id="edittrip">
			<fieldset class="code">
				<h2>Ange din redigeringskod</h2>
				<div id="generals">
					<p class="regular">När du registrerade din resa fick du en kod.</p>
						<xsl:call-template name="inputfield">
							<xsl:with-param name="inputid" select="'code'" />
							<xsl:with-param name="inputlabel" select="'Kod'" />
						</xsl:call-template>
					<a class="forgotten" href="/sendcode">Klicka här om du glömt koden och vill få koden mailad till dig.</a>
					<input class="button" type="submit" value="Ändra resa" />
					<input type="hidden" name="posted" />
				</div>
			</fieldset>
		</form>
	</xsl:template>

	<xsl:template name="sendcode_form">
		<form class="trip" method="post" action="/sendcode" id="sendcode">
			<fieldset class="email">
				<h2>Ange din E-postadress</h2>
				<div id="generals">
					<p class="regular">Ange din E-postadress</p>
						<xsl:call-template name="inputfield">
							<xsl:with-param name="inputid" select="'email'" />
							<xsl:with-param name="inputlabel" select="'E-post'" />
						</xsl:call-template>
					<input class="button" type="submit" value="Skicka kod" />
				</div>
			</fieldset>
		</form>
	</xsl:template>

	<xsl:template name="message_box">
		<xsl:param name="title" />
		<xsl:param name="message" />
		<div class="message_box">
			<h2><xsl:value-of select="$title" /></h2>
			<p class="regular"><xsl:value-of select="$message" /></p>
		</div>
	</xsl:template>

	<xsl:template name="message">
		<xsl:param name="button" />
		<xsl:param name="type" />
		<div id="messages">
			<xsl:attribute name="class">
				<xsl:value-of select="$type"/>
				<xsl:if test="$type = '' or not($type)">
					<xsl:text> passenger</xsl:text>
				</xsl:if>
			</xsl:attribute>
			<p>
				<xsl:if test="/root/content/trips/*">Om du inte hittar någon resa härunder kan du spara resan så att <em> andra kan hitta dig</em>.</xsl:if>
				<xsl:if test="not(/root/content/trips/*)">Vi hittade inga resor, prova att ändra i sökningen eller spara din resa.</xsl:if>
			</p>
			<a class="button">
				<xsl:attribute name="href">
					<xsl:text>addtrip?from=</xsl:text>
					<xsl:value-of select="/root/meta/url_params/from" />
					<xsl:text>&amp;to=</xsl:text>
					<xsl:value-of select="/root/meta/url_params/to" />
					<xsl:text>&amp;when=</xsl:text>
					<xsl:value-of select="/root/meta/url_params/when" />
					<xsl:if test="/root/meta/url_params/got_car">
						<xsl:text>&amp;got_car=</xsl:text>
						<xsl:value-of select="1 - /root/meta/url_params/got_car" />
					</xsl:if>

				</xsl:attribute>
				<xsl:text>Spara resa</xsl:text>
			</a>
		</div>
	</xsl:template>

	<xsl:template name="searchresults">
		<xsl:param name="type" />
		<xsl:if test="/root/content/trips/*">
			<div id="searchresults">
				<xsl:attribute name="class">
					<xsl:value-of select="$type"/>
					<xsl:if test="$type = '' or not($type)">
						<xsl:text> passenger</xsl:text>
					</xsl:if>
				</xsl:attribute>
				<h2>
					<xsl:value-of select="count(/root/content/trips/trip)" />
					<xsl:if test="count(/root/content/trips/trip) = 1">
						<xsl:text> Hittad </xsl:text>
						<xsl:choose>
							<xsl:when test="/root/meta/url_params/got_car = 1">bilplats</xsl:when>
							<xsl:when test="/root/meta/url_params/got_car = 0">passagerare</xsl:when>
							<xsl:otherwise>resa till eller från <xsl:value-of select="/root/meta/url_params/q" /></xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<xsl:if test="count(/root/content/trips/trip) > 1">
						<xsl:text> Hittade </xsl:text>
						<xsl:choose>
							<xsl:when test="/root/meta/url_params/got_car = 1">bilplatser</xsl:when>
							<xsl:when test="/root/meta/url_params/got_car = 0">passagerare</xsl:when>
							<xsl:otherwise>resor</xsl:otherwise>
						</xsl:choose>
					<xsl:if test="/root/meta/url_params/q and not(/root/meta/url_params/q = '')" >
						<xsl:value-of select="'till eller från '" />
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
					</xsl:if>
				</h2>
				<table>
					<thead>
						<tr>
							<th class="destination">Från</th>
							<th class="destination">Till</th>
							<th class="time">När</th>
						</tr>
					</thead>
					<tbody>
						<tr class="spacing">
							<td></td>
						</tr>
						<xsl:for-each select="trips/trip">
							<tr>
								<xsl:attribute name="class">
									<xsl:text>generals</xsl:text>
									<xsl:if test="(position() mod 2 = 1)">
										<xsl:text> odd</xsl:text>
									</xsl:if>
									<xsl:if test="(position() mod 2 = 0)">
										<xsl:text> even</xsl:text>
									</xsl:if>
								</xsl:attribute>
								<td>
									<xsl:call-template name="place_cleaner">
										<xsl:with-param name="place"   select="from" />
									</xsl:call-template>
								</td>
								<td>
									<xsl:call-template name="place_cleaner">
										<xsl:with-param name="place"   select="to" />
									</xsl:call-template>								</td>
								<td>
									<xsl:value-of select="substring(when_iso, 0, 11)" />
								</td>
							</tr>
							<tr>
								<xsl:attribute name="class">
									<xsl:text>details</xsl:text>
									<xsl:if test="(position() mod 2 = 1)">
										<xsl:text> odd</xsl:text>
									</xsl:if>
									<xsl:if test="(position() mod 2 = 0)">
										<xsl:text> even</xsl:text>
									</xsl:if>
								</xsl:attribute>
								<td>
									<em>Namn: </em>
									<xsl:value-of select="substring(name, 0)" />
									<br />
									<em>Telefon: </em>
									<xsl:value-of select="substring(phone, 0)" />
								</td>
								<td colspan="2">
									<em>Detaljer: </em>
									<xsl:value-of select="substring(details, 0)" />
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
			</div>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="place_cleaner">
		<xsl:param name="place" />
		<xsl:choose>
			<xsl:when test="substring($place,string-length($place) - 14,15) = ' County, Sweden'">
				<xsl:value-of select="substring($place, 0, string-length($place) - 14)" />
			</xsl:when>
			
			<xsl:when test="substring($place,string-length($place) - 20,21) = ' Municipality, Sweden'">
				<xsl:value-of select="substring($place, 0, string-length($place) - 20)" />
			</xsl:when>
			
			<xsl:when test="substring($place,string-length($place) - 7,8) = ', Sweden'">
				<xsl:value-of select="substring($place, 0, string-length($place) - 7)" />
			</xsl:when>
			
			
			<xsl:otherwise>
				<xsl:value-of select="$place"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
		<xsl:template name="get_weekday">
		<xsl:param name="when" />
		<xsl:choose>
			<xsl:when test="(floor($when div 86400))mod 7 = 3">
				<xsl:text>måndag</xsl:text>
			</xsl:when>
			<xsl:when test="(floor($when div 86400))mod 7 = 4">
				<xsl:text>tisdag</xsl:text>
			</xsl:when>
			<xsl:when test="(floor($when div 86400))mod 7 = 5">
				<xsl:text>onsdag</xsl:text>
			</xsl:when>
			<xsl:when test="(floor($when div 86400))mod 7 = 6">
				<xsl:text>torsdag</xsl:text>
			</xsl:when>
			<xsl:when test="(floor($when div 86400))mod 7 = 0">
				<xsl:text>fredag</xsl:text>
			</xsl:when>
			<xsl:when test="(floor($when div 86400))mod 7 = 1">
				<xsl:text>lördag</xsl:text>
			</xsl:when>
			<xsl:when test="(floor($when div 86400))mod 7 = 2">
				<xsl:text>söndag</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!-- convert line feed to <br /> -->
	<xsl:template name="lf2br">
		<xsl:param name="stringToTransform"/>
		<xsl:choose>
			<xsl:when test="contains($stringToTransform,'&#xA;')">
				<xsl:value-of select="substring-before($stringToTransform,'&#xA;')"/>
				<br/>
				<xsl:call-template name="lf2br">
					<xsl:with-param name="stringToTransform">
						<xsl:value-of select="substring-after($stringToTransform,'&#xA;')"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$stringToTransform"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
