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

	<xsl:template name="title">Samåkning på enkelt vis. Gör naturen och din plånbok en tjänst, Res Ihop!</xsl:template>
	<xsl:template name="goal" />

	<xsl:template name="description">Hitta människor för samåkning, ingen registrering, inget krångel! Det är bara att lägga upp resan som passagerare eller förare.</xsl:template>

	<xsl:template match="/">
		<xsl:call-template name="base" />
	</xsl:template>

	<!-- About page -->
	<xsl:template match="/root/content[../meta/path = 'about']">
		<div class="freetext">
		<h2>Samåkningssiter finns det asmånga. Asmånga!</h2>
		<p>Vi bygger en site vars mål är att samla ihop alla samåkningar och göra det väldigt enkelt att dels söka i dem och lägga upp nya. Vår supersmarta sökmotor förstår var adresser ligger, vi lanserade nyss v.2 av resihop. Den har typ 50% färre funktioner än den förra versionen! Tillexempel kan man bland annat lägga till nya resor utan att regga konton och sånt. o/\o</p>

		<p>Vidare är all data offentligt tillgänglig via xml (som datorer älskar (omnomnom)) ifall någon vill bygga någor. Kolla bara källkoden och om ni har några frågor kontakta <a href="mailto:hurbel@yahoo.com">lilleman</a>!</p>
		<br />
		<br />
		<img src="/images/eu.gif" />
		<p style="font-family: 'Tahoma'">Projektet genomförs med ekonomiskt stöd från Europeiska kommissionen. För uppgifterna i denna publikation (meddelande) ansvarar endast upphovsmannen. Europeiska kommissionen tar inget ansvar för hur dessa uppgifter kan komma att användas</p>
		</div>
	</xsl:template>

	<!-- Contact page -->
	<xsl:template match="/root/content[../meta/path = 'contact']">
		<div class="freetext">
		<p>Snabbaste sättet att tycka är att klicka på tycktill-kappen här till höger.</p>
		<p>Vill ni prata med oss mer privat eller bara föredrar språk</p>
		<p><em>Kristoffer Nolgren</em></p>
		<p>Samarbeten med mera</p>
		<p>070 464 97 97</p>
		<p>msn: krill@eldsjal.org</p>
		<p>e-mail: <a href="mailto:kristoffer@nolgren.se">kristoffer@nolgren.se</a></p>
		<a href="http://www.facebook.com/kristoffer.nolgren">facebook</a>
		<p><em>Mikael Göransson</em></p>
		<p>teknik med mera</p>
		<p>070 043 56 84</p>
		<p>icq: 47526873 </p>
		<p>e-mail: <a href="mailto:hurbel@yahoo.com">hurbel@yahoo.com</a></p>
		<a href="http://www.facebook.com/lillem4n">facebook</a>
		</div>
	</xsl:template>

	<!-- API page (ge fan i att ändra indraget pga cdata-->
	<xsl:template match="/root/content[../meta/path = 'api']">
<div class="freetext">
<h2>Grundläggande principer</h2> 
<h3>Vad är ett api?</h3> 
<p>Api står för ”Application programming interface”, dvs ett sätt för andra program och system kommer åt vår information (tillexempel vilka resor som finns på resihop) och våra funktioner (som sökning och sparning av resor).  </p> 
<h3>Http-anrop</h3> 
<p>Utan att veta om det gör du säkert flera hundra http-anrop om dagen. Ett http-anrop görs tillexempel när du ladda en hemsida. Om du skriver <a href="http://resihop.nu">http://resihop.nu</a>/ i din webbläsare, så anropas sidan med hjälp av protokollet http och som svar får du vår startsida!</p> 
<h4>Url</h4> 
<p>Url står för Uniform Resource Locator, och är adressen som berättar vilket http-anrop som ska göras <a href="http://resihop.nu">http://resihop.nu</a>/ är tillexempel en url. </p> 
<h4>Parametrar</h4> 
<p>En url kan innehålla parametrar, de krokas på i slutet av adressen med ett frågetecken, tillexempel innehåller <a href="http://resihop.nu">http://resihop.nu</a>/search?from=stockholm parametern from och parameterns värde är "stockholm". Ifall man vill skicka med flera parametrar så gör man det med hjälp av ett &amp;-tecken, den här adressen innehåller två parametrar: <a href="http://resihop.nu/search?from=stockholm&amp;to=göteborg">http://resihop.nu/search?from=stockholm&amp;to=göteborg</a>. </p> 
<h3>Xml</h3> 
<p>Xml är ett format att spara data i. All interaktion med resihop får svar i form av xml-filer. Det är viktigt att ha en viss förståelse för xml om man ska använda resihop, du kan läsa mer om xml här</p> 
<h2>Om resihops teknologi</h2> 
<h3>Förkunskapskrav</h3> 
<p>XML-konvertering</p> 
<p>Förståelse för http</p> 
<p>Något att konvertera xml med, t.ex. xslt, ruby, php eller något Content-management-system som kan importera xml.</p> 
<p>Om du inte känner till de här begreppen kan du läsa lite om grunderna här.</p> 
<h3>Om resihop</h3> 
<p>Resihop är en teknisk plattform för att hitta och dela med sig av tomma bilplatser för att spara på miljön och plånboken. Det finns väldigt många system och hemsidor för samåkning, vi försöker bidra med att samla alla de resor som finns där ute och dessutom göra dem lättare att söka bland med hjälp av vår platsmedvetna sökmotor.</p> 
<p>Hela vår sida och all funktionalitet är byggt med vårt eget api. Ni kan alltså bygga minst lika bra saker som vi har byggt! Hör gärna av er till oss om ni har några frågor eller funderingar.</p> 
<h3>Generellt om api:et</h3> 
<p>Det finns 4 funktioner i api:et. De anropas med hjälp av http. Alla anrop besvaras med en xml-fil. För att interagera med vårt system måste varje http-anrop också få med parametrar.</p> 
<h3>Vår implementation av api:et</h3> 
<p>Vi har valt att använda xslt för att modifiera xml-koden för resihop. Om du på någon sida på resihop.nu väljer att visa källan, kommer du därför att se xml-koden som api:et skickar ut.</p> 
<h3>Testmiljö</h3> 
<p>Vi har en testversion av api:et med en separat databas på dev.resihop.nu. Använd den för att testa din integrering, så inte felaktiga resor sparas i live-versionen av siten. Du kommer åt testmiljön gör du genom att lägga till ”dev.” i alla http-anrops. OBS! Spara ingen viktig information på dev.resihop.nu, den kan försvinna när som helst.</p> 
<h3>Funktionerna</h3> 
<h4>Sök </h4> 
<p>Vår sökmotor vet var alla platser är. Det gör att vi kan göra smarta sökningar, där resihop förstår vilka städer och adresser som ligger nära varandra. Letar du tillexempel efter en resa mellan Uppsala och Göteborg, får du också förslag på resor från Stockholm och Göteborg. Sökmotorn har platser i hela världen och är inte begränsad till Sverige.</p> 
<p>Läs mer sökmotorn och hur den fungerar i kodexen.</p> 
<h4>Spara resa</h4> 
<p>Att spara resor är enkelt. Det krävs ingen inloggning eller autenciering. När man sparar en resa får man tillbaka en kod som sen kan användas för att redigera resan.</p> 
<p>Läs mer om spara-resa-funktionen och hur den fungerar i kodexen.</p> 
<h4>Redigera och ta bort resa</h4>
<p>Att redigera en resa görs på ungefär samma sätt som man sparar en resa, med skillnaden att man också skickar med en kod som en parameter.</p> 
<p>Läs mer om redigera-resa-funktionen och hur den fungerar i kodexen.</p> 
<h4>Glömt koden</h4>
<p>Om man glömt en kod kan man skicka sin E-post adress till resihop. Då skickar resihop ut koden för alla resor kopplade till den E-post-adressen.</p> 
<p>Läs mer om glömt-koden-funktionen och hur den fungerar i kodexen.</p> 
<h3>Ett exempel</h3>
<p>Om du gör http-anropet <a href="http://resihop.nu/search?to=stockholm&amp;from=lund">http://resihop.nu/search?to=stockholm&amp;from=lund</a> i får du som svar något i stil med:</p>
<code>
<pre>
	<![CDATA[
<?xml version="1.0" encoding="UTF-8"?> 
<?xml-stylesheet type="text/xsl" href="/xsl/search.xsl"?> 
<root> 
  <meta> 
    <protocol>http</protocol> 
    <domain>resihop.nu</domain> 
    <base>/</base> 
    <path>search</path> 
    <action>index</action> 
    <controller>search</controller> 
    <url_params> 
      <from>lund</from> 
      <to>stockholm</to> 
      <when></when> 
      <got_car>0</got_car> 
    </url_params> 
    <version>2.0</version> 
    <errors> 
      <error> 
        <message>Invalid format</message> 
        <data> 
          <param>when</param> 
        </data> 
      </error> 
    </errors> 
  </meta> 
  <content> 
    <trips> 
      <trip> 
        <trip_id>260</trip_id> 
        <from_lon>59.3328</from_lon> 
        <from_lat>18.0645</from_lat> 
        <to_lon>57.6970</to_lon> 
        <to_lat>11.9865</to_lat> 
        <when>1288216800</when> 
        <got_car>0</got_car> 
        <details>öakjf</details> 
        <inserted>1288103029</inserted> 
        <name>Kristoffer Nolgren</name> 
        <email>kristoffer@nolgren.se</email> 
        <phone>0704649797</phone> 
        <from>Lund, Sweden</from> 
        <to>Stockholm, Sweden</to> 
        <when_iso>2010-10-28 00:00</when_iso> 
      </trip> 
      <trip> 
        <trip_id>274</trip_id> 
        <from_lon>59.3328</from_lon> 
        <from_lat>18.0645</from_lat> 
        <to_lon>57.6970</to_lon> 
        <to_lat>11.9865</to_lat> 
        <when>1288216800</when> 
        <got_car>0</got_car> 
        <details>öakjf</details> 
        <inserted>1288111539</inserted> 
        <name>Kristoffer Nolgren</name> 
        <email>kristoffer@nolgren.se</email> 
        <phone>0704649797</phone> 
        <from>Lund, Sweden</from> 
        <to>Stockholm, Sweden</to> 
        <when_iso>2010-10-28 00:00</when_iso> 
      </trip> 
    </trips> 
  </content> 
</root>
  ]]>
</pre>
</code>
<p>I vår kodex förklaras hur såväl parametrarna som noderna fungerar.</p> 
<h2>Kodex/Ordlista</h2> 
<p>I den här ordlistan beskrivs alla de noder, funktioner och meddelanden man får och kan skicka när man interagerar med resihops API.</p> 
<h3>Nodträdet</h3> 
<p>Nodträdet är indelat i meta och Content. Eftersom meta fungerar likadant i varje funktion, medan content varierar från funktion till funktion.  </p> 
<h3>Meta</h3>
<h4>Xml-noder</h4>
 
<table> 
  <tbody> 
    <tr> 
      <td> 
        Nod
      </td> 
      <td> 
        Förklaring 
      </td> 
    </tr> 
    <tr> 
      <td> 
        Protocol 
      </td> 
      <td> 
        @lilleman 
      </td> 
    </tr> 
    <tr> 
      <td> 
        Domain 
      </td> 
      <td> 
        Vilken domän http-anropet är gjort till 
      </td> 
    </tr> 
    <tr> 
      <td> 
        Base 
      </td> 
      <td> 
        @lilleman 
      </td> 
    </tr> 
    <tr> 
      <td> 
        Path
      </td> 
      <td> 
        Vilken adress som pekar på xml-filen du nu läser. (@Lilleman?)
      </td> 
    </tr> 
    <tr> 
      <td> 
        Action 
      </td> 
      <td> 
        @lilleman 
      </td> 
    </tr> 
    <tr> 
      <td> 
        Controller 
      </td> 
      <td> 
        Vilken funktion som används, kan vara search, addtrip, edittrip och sendform 
      </td> 
    </tr> 
    <tr> 
      <td> 
        Version 
      </td> 
      <td> 
        Vilken version av api:et du anropar.
      </td> 
    </tr> 
    <tr> 
      <td> 
        Errors 
      </td> 
      <td> 
        Förälder-nod till error 
      </td> 
    </tr> 
    <tr> 
      <td> 
        Error 
      </td> 
      <td> 
        Eventuella felmeddelanden på grund av felaktiga eller saknade parametrar. Varje funktion har olika felmeddelanden, därför tas felmeddelandena upp under respektive nod.
      </td> 
    </tr> 
    <tr> 
      <td> 
        Message 
      </td> 
      <td> 
        Vilken typ av felmeddelande det är
      </td> 
    </tr> 
    <tr> 
      <td> 
        Data
      </td> 
      <td> 
        Förälder-nod till parametrar i felmeddelandet
      </td> 
    </tr> 
    <tr> 
      <td> 
        Param
      </td> 
      <td> 
        Vilken parameter felmeddelandet berör. 
      </td> 
    </tr> 
    <tr> 
      <td> 
        Option
      </td> 
      <td> 
        Om vårt system inte förstår en adress du söker efter, föreslår den alternativ. Finns bara ett alternativ väljs det automatiskt. 
      </td> 
    </tr> 
  </tbody> 
</table> 
<h4>Exempel</h4> 
<p>I exemplet nedan syns metanoden från http-anropet <br />
<a href="http://resihop.nu/search?to=stockholm&amp;from=lund">http://resihop.nu/search?to=stockholm&amp;from=lund</a><br /> kan vi se hur url-en är nerbrutet i olika xml-noder. Dessutom får vi information om att prametern ”when” inte har rätt format.</p>
<code>
<pre>
<![CDATA[
  <meta> 
   <protocol>http</protocol> 
    <domain>resihop.nu</domain> 
    <base>/</base> 
    <path>search</path> 
    <action>index</action> 
    <controller>search</controller> 
    <url_params> 
      <from>lund</from> 
      <to>stockholm</to> 
      <when></when> 
      <got_car>0</got_car> 
    </url_params> 
    <version>2.0</version> 
    <errors> 
      <error> 
        <message>Invalid format</message> 
        <data> 
          <param>when</param> 
        </data> 
      </error> 
    </errors> 
  </meta>
  ]]>
</pre>
</code> 
<h3>Sök</h3> 
<p>Vår sökmotor vet var alla platser är. Det gör att vi kan göra smarta sökningar, där resihop förstår vilka städer och adresser som ligger nära varandra. Letar du tillexempel efter en resa mellan Uppsala och Göteborg, får du också förslag på resor från Stockholm och Göteborg. Sökmotorn har platser i hela världen och är inte begränsad till Sverige.</p> 
<h4>HTTP-anrop</h4>
<a href="http://resihop.nu/search">http://resihop.nu/search</a> 
<h4>Parametrar och felmeddelanden</h4>
<p>Ingen av dessa parametrar är obligatoriska för att göra en sökning.</p> 
 
<table> 
  <tbody> 
    <tr> 
      <td> 
        Parameter 
      </td> 
      <td> 
        Felmeddelande 
      </td> 
      <td> 
        Förklaring 
      </td> 
    </tr> 
    <tr> 
      <td> 
        from 
      </td> 
      <td> 
      </td> 
      <td> 
        Avreseort för den sökning man vill göra. Om adressen inte stämmer men det bara finns ett lämplig alternativ kommer.
      </td> 
    </tr> 
    <tr> 
      <td> 
        to 
      </td> 
      <td>  
      </td> 
      <td> 
        Ankomstort för den sökning man vill göra
      </td> 
    </tr> 
    <tr> 
      <td> 
      </td> 
      <td> 
        Address is not unique
      </td> 
      <td> 
        Det finns flera adresser som passar för din sökning. Låt användaren välja en i listan av options.
      </td> 
    </tr> 
    <tr> 
      <td> 
      </td> 
      <td> 
        Invalid address
      </td> 
      <td> 
        Den adress du angav finns eller stämmer inte. Orsaker kan vara tillexempel felstavning eller att platsen bara finns i användarens fantasi. 
      </td> 
    </tr> 
    <tr> 
      <td> 
        when 
      </td> 
      <td> 
         
      </td> 
      <td> 
        Det datum du vill göra sökningen på. Hittas inga träffar det datumet utvidgas sökningen till andra datum i närheten. 
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Invalid format 
      </td> 
      <td> 
        Datum måste anges i formatet YYYY-MM-DD eller YYYY-MM-DD HH:MM 
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Must be a future timestamp 
      </td> 
      <td> 
        Det går inte att söka på datum som redan har varit. 
      </td> 
    </tr> 
    <tr> 
      <td> 
        has_car 
      </td> 
      <td> 
         
      </td> 
      <td> 
        Om man letar efter bilplats eller medresenärer. 1 om man har bilplats, 0 om man letar medresenärer. 
      </td> 
    </tr> 
  </tbody> 
</table> 
 
<h4>Noder</h4> 
<table> 
  <tbody> 
    <tr> 
      <td> 
        Nod
      </td> 
      <td> 
        Förklaring
      </td> 
    </tr> 
    <tr> 
      <td> 
        trips
      </td> 
      <td> 
        Förälder till trip
      </td> 
    </tr> 
    <tr> 
      <td> 
        trip
      </td> 
      <td> 
        Varje trip-nod består av information om just den resan
      </td> 
    </tr> 
    <tr> 
      <td> 
        trip_id
      </td> 
      <td> 
        Varje trips unika id-nummer
      </td> 
    </tr> 
    <tr> 
      <td> 
        from_lon
      </td> 
      <td> 
        Longituden man åker ifrån
      </td> 
    </tr> 
    <tr> 
      <td> 
        from_lat
      </td> 
      <td> 
        Latituden man åker ifrån
      </td> 
    </tr> 
    <tr> 
      <td> 
        to_lon
      </td> 
      <td> 
        Longituden man åker till
      </td> 
    </tr> 
    <tr> 
      <td> 
        to_lat
      </td> 
      <td> 
        Latituden man åker till
      </td> 
    </tr> 
    <tr> 
      <td> 
        when
      </td> 
      <td> 
        När resan avgår, i UNIX timestamp
      </td> 
    </tr> 
    <tr> 
      <td> 
        got_car
      </td> 
      <td> 
        Huruvida annonsören har en bil eller söker en bilplats
      </td> 
    </tr> 
    <tr> 
      <td> 
        details
      </td> 
      <td> 
        Detaljer som annonsören har lagt till
      </td> 
    </tr> 
    <tr> 
      <td> 
        inserted
      </td> 
      <td> 
        @lilleman
      </td> 
    </tr> 
    <tr> 
      <td> 
        email
      </td> 
      <td> 
        Annonsörens E-post-adress
      </td> 
    </tr> 
    <tr> 
      <td> 
        from
      </td> 
      <td> 
        Adressen man åker från
      </td> 
    </tr> 
    <tr> 
      <td> 
        to
      </td> 
      <td> 
        Adressen man åker till
      </td> 
    </tr> 
    <tr> 
      <td> 
        phone
      </td> 
      <td> 
        Telefonnummer angett av annonsören
      </td> 
    </tr> 
    <tr> 
      <td> 
        when_iso
      </td> 
      <td> 
        När annonsören vill åka, i unix-timestamp. Om tiden är 00:00 är det antagligen för att annonsören inte angivit någon tid.
      </td> 
    </tr> 
  </tbody> 
</table> 
 
<h4>Exempel</h4> 
<p>Om vi gör http-anropet</p> 
<p><a href="http://www.resihop.nu/search?from=Stockholm, sweden&amp;got_car=0">http://www.resihop.nu/search?from=Stockholm, sweden&amp;got_car=0</a> kan vi kan vi se att fältet when har fel format, eftersom det är tomt, men trots det får vi två sökresultat, ett från Gnesta och ett från Stockholm. Detta beror på att when inte är ett obligatoriskt fält.</p> 
<code>
<pre>
<![CDATA[
  <content> 
    <trips> 
      <trip> 
        <trip_id>261</trip_id> 
        <from_lon>57.6970</from_lon> 
        <from_lat>11.9865</from_lat> 
        <to_lon>58.3912</to_lon> 
        <to_lat>13.8473</to_lat> 
        <when>1289084400</when> 
        <got_car>0</got_car> 
        <details></details> 
        <inserted>1286882091</inserted> 
        <name>Filippa Levemark</name> 
        <email>filippa.levemark@gmail.com</email> 
        <phone>0702910528</phone> 
        <from>Stockholm, Sweden</from> 
        <to>Skövde, Sweden</to> 
        <when_iso>2010-11-07 00:00</when_iso> 
      </trip> 
      <trip> 
        <trip_id>259</trip_id> 
        <from_lon>59.3328</from_lon> 
        <from_lat>18.0645</from_lat> 
        <to_lon>55.6763</to_lon> 
        <to_lat>12.5681</to_lat> 
        <when>1289516400</when> 
        <got_car>0</got_car> 
        <details>Jag söker resa från Stockholm till Köpenhamn/ Malmö någon gång 10-12/11. Kan bidra med muntra samtal och bensinpeng.</details> 
        <inserted>1286451583</inserted> 
        <name>Elin Jonzon</name> 
        <email>e_jonzon@hotmail.com</email> 
        <phone>0704073504</phone> 
        <from>Gnesta, Sweden</from> 
        <to>Copenhagen, Denmark</to> 
        <when_iso>2010-11-12 00:00</when_iso> 
      </trip> 
    </trips> 
  </content> 
</root>
]]>
</pre>
</code>
<h3>Spara resa</h3> 
<p>Att redigera en resa görs på ungefär samma sätt som man sparar en resa, med skillnaden att man också skickar med en kod som en parameter.</p> 
<p><b></b><br /></p> 
<h4>HTTP-anrop</h4>
<a href="http://www.resihop.nu/addtrip">http://www.resihop.nu/addtrip</a>
<h4>Parametrar och felmeddelanden</h4>
<p>Parametrar med en asterix är obligatoriska.</p> 
 
<table> 
  <tbody> 
    <tr> 
      <td> 
        Parameter
      </td> 
      <td> 
        Felmeddelande
      </td> 
      <td> 
        Förklaring
      </td> 
    </tr> 
    <tr> 
      <td> 
        from
      </td> 
      <td> 
         
      </td> 
      <td> 
        Avreseort för den sökning man vill göra. Om adressen inte stämmer men det bara finns ett lämplig alternativ kommer 
      </td> 
    </tr> 
    <tr> 
      <td> 
        to*
      </td> 
      <td> 
         
      </td> 
      <td> 
        Ankomstort för den sökning man vill göra
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Address is not unique
      </td> 
      <td> 
        Det finns flera adresser som passar för din sökning. Låt användaren välja en i listan av options.
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Invalid address
      </td> 
      <td> 
        Den adress du angav finns eller stämmer inte. Orsaker kan vara tillexempel felstavning eller att platsen bara finns i användarens fantasi.
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Required
      </td> 
      <td> 
        Du måste ange en avreseort och en ankomstort
      </td> 
    </tr> 
    <tr> 
      <td> 
        when*
      </td> 
      <td> 
         
      </td> 
      <td> 
        Det datum du vill göra sökningen på. Hittas inga träffar det datumet utvidgas sökningen till andra datum i närheten.
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Invalid format
      </td> 
      <td> 
        Datum måste anges i formatet YYYY-MM-DD eller YYYY-MM-DD HH:MM
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Must be a future timestamp
      </td> 
      <td> 
        Det går inte att söka på datum som redan har varit.
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Required
      </td> 
      <td> 
        Du måste ange ett datum för resan
      </td> 
    </tr> 
    <tr> 
      <td> 
        has_car*
      </td> 
      <td> 
         
      </td> 
      <td> 
        Om man letar efter bilplats eller medresenärer. 1 om man har bilplats, 0 om man letar medresenärer.
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Required
      </td> 
      <td> 
        Du måste ange om du har bilplats eller söker en bilplats
      </td> 
    </tr> 
    <tr> 
      <td> 
        name*
      </td> 
      <td> 
         
      </td> 
      <td> 
        Annonsörens namn
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Required
      </td> 
      <td> 
        Du måste ange ett namn
      </td> 
    </tr> 
    <tr> 
      <td> 
        email*
      </td> 
      <td> 
         
      </td> 
      <td> 
        Annonsörens e-post-adress. Det är hit koden skickas för påminnelse.
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Required
      </td> 
      <td> 
        Du måste ange en e-postadress
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Not valid email
      </td> 
      <td> 
        Du måste ange en e-post-adress enligt korrekt format.
      </td> 
    </tr> 
    <tr> 
      <td> 
        phone*
      </td> 
      <td> 
         
      </td> 
      <td> 
         
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Required
      </td> 
      <td> 
        Du måste ange ett telefonnummer
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Invalid format
      </td> 
      <td> 
        Telefonnummer får inte innehålla några bokstäver
      </td> 
    </tr> 
    <tr> 
      <td> 
        Details
      </td> 
      <td> 
         
      </td> 
      <td> 
        Detaljer om resan, tillexempel gällande rökning, hundar, packning, var man ska samlas. Hur mycket det kostar osv.
      </td> 
    </tr> 
  </tbody> 
</table> 
 
<h4>Noder</h4> 
 
<table> 
  <tbody> 
    <tr> 
      <td> 
        Nod
      </td> 
      <td> 
        Förklaring
      </td> 
    </tr> 
    <tr> 
      <td> 
        new_trip
      </td> 
      <td> 
        Förälder till den nyinlagda resan
      </td> 
    </tr> 
    <tr> 
      <td> 
        trip_id
      </td> 
      <td> 
        Den tillagda resans varje trips unika id-nummer
      </td> 
    </tr> 
    <tr> 
      <td> 
        from_lon
      </td> 
      <td> 
        Longituden man åker ifrån
      </td> 
    </tr> 
    <tr> 
      <td> 
        from_lat
      </td> 
      <td> 
        latituden man åker ifrån
      </td> 
    </tr> 
    <tr> 
      <td> 
        to_lon
      </td> 
      <td> 
        Longituden man åker till
      </td> 
    </tr> 
    <tr> 
      <td> 
        to_lat
      </td> 
      <td> 
        Latituden man åker till
      </td> 
    </tr> 
    <tr> 
      <td> 
        when
      </td> 
      <td> 
        När resan avgår, i UNIX timestamp
      </td> 
    </tr> 
    <tr> 
      <td> 
        got_car
      </td> 
      <td> 
        Huruvida annonsören har en bil eller söker en bilplats
      </td> 
    </tr> 
    <tr> 
      <td> 
        details
      </td> 
      <td> 
        Detaljer som annonsören har lagt till
      </td> 
    </tr> 
    <tr> 
      <td> 
        inserted
      </td> 
      <td> 
        @lilleman
      </td> 
    </tr> 
    <tr> 
      <td> 
        email
      </td> 
      <td> 
        Annonsörens e-post-adress
      </td> 
    </tr> 
    <tr> 
      <td> 
        from
      </td> 
      <td> 
        Adressen man åker från
      </td> 
    </tr> 
    <tr> 
      <td> 
        to
      </td> 
      <td> 
        adressen man åker till
      </td> 
    </tr> 
    <tr> 
      <td> 
        phone
      </td> 
      <td> 
        telefonnummer angett av annonsören
      </td> 
    </tr> 
    <tr> 
      <td> 
        when_iso
      </td> 
      <td> 
        När annonsören vill åka, i unix-timestamp. Om tiden är 00:00 är det antagligen för att annonsören inte angivit någon tid.
      </td> 
    </tr> 
    <tr> 
      <td> 
        code
      </td> 
      <td> 
        En unik kod för din resa som används i funktionerna edittrip och deletetrip 
      </td> 
    </tr> 
  </tbody> 
</table> 
 
<h4>Exempel</h4>
<p>Om vi gör http-anropet</p> 
<p><a href="http://dev.resihop.nu/addtrip?from=stockholm&amp;to=göteborg&amp;when=2010-10-28&amp;name=Kristoffer+Nolgren&amp;email=kristoffer%40nolgren.se&amp;phone=0704649797&amp;details=Oavsett+hur+många+vi+blir+så+delar+vi+på+500+kronor+i+resekostnad.&amp;got_car=0">http://dev.resihop.nu/addtrip?from=stockholm&amp;to=göteborg&amp;when=2010-10-28&amp;name=Kristoffer+Nolgren&amp;email=kristoffer%40nolgren.se&amp;phone=0704649797&amp;details=Oavsett+hur+många+vi+blir+så+delar+vi+på+500+kronor+i+resekostnad.&amp;got_car=0</a>.  
Får vi mycket riktigt ett svar med alla detaljer för resan.</p> 
<code>
<pre>
	<![CDATA[
<content> 
  <new_trip> 
    <trip_id>270</trip_id> 
    <from>Stockholm, Sweden</from> 
    <from_lat>18.0645</from_lat> 
    <from_lon>59.3328</from_lon> 
    <to>Gothenburg, Sweden</to> 
    <to_lat>11.9865</to_lat> 
    <to_lon>57.6970</to_lon> 
    <when>1288216800</when> 
    <when_iso>2010-10-28 00:00</when_iso> 
    <details>Oavsett hur många vi blir så delar vi på 500 kronor i resekostnad.</details> 
    <got_car>0</got_car> 
    <inserted>1288191470</inserted> 
    <name>Kristoffer Nolgren</name> 
    <email>kristoffer@nolgren.se</email> 
    <phone>0704649797</phone> 
    <code>CEAD5HEW29TC</code> 
  </new_trip> 
</content>
]]>
</pre>
</code>
<h3>Redigera och ta bort resa</h3> 
<p>Att spara resor är enkelt. Det krävs ingen inloggning eller autenciering. När man sparar en resa får man tillbaka en kod som sen kan användas för att redigera resan. För att ändra en resa, skicka med de parametrar du vill ändra, samt den unika koden för din resa. Tomma parametrar bevaras som de är. För att ta bort en resa, skicka parametern remove.</p> 
 
<h4>HTTP-anrop</h4>
<a href="http://www.resihop.nu/edittrip">http://www.resihop.nu/edittrip</a>
<h4>Parametrar och felmeddelanden</h4>
<p>Parametrar med en asterix är obligatoriska.</p> 
 
<table> 
  <tbody> 
    <tr> 
      <td> 
        Parameter
      </td> 
      <td> 
        Felmeddelande
      </td> 
      <td> 
        Förklaring
      </td> 
    </tr> 
    <tr> 
      <td> 
        code*
      </td> 
      <td> 
         
      </td> 
      <td> 
        Den unika kod som autencierar förändringar i resan
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Invalid
      </td> 
      <td> 
        Koden du angett stämmer inte överens med någon resa.
      </td> 
    </tr> 
    <tr> 
      <td> 
        from
      </td> 
      <td> 
         
      </td> 
      <td> 
        Avreseort för den sökning man vill göra. Om adressen inte stämmer men det bara finns ett lämplig alternativ kommer 
      </td> 
    </tr> 
    <tr> 
      <td> 
        to
      </td> 
      <td> 
         
      </td> 
      <td> 
        Ankomstort för den sökning man vill göra
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Address is not unique
      </td> 
      <td> 
        Det finns flera adresser som passar för din sökning. Låt användaren välja en i listan av options.
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Invalid address
      </td> 
      <td> 
        Den adress du angav finns eller stämmer inte. Orsaker kan vara tillexempel felstavning eller att platsen bara finns i användarens fantasi.
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Required
      </td> 
      <td> 
        Du måste ange en avreseort och en ankomstort
      </td> 
    </tr> 
    <tr> 
      <td> 
        when
      </td> 
      <td> 
         
      </td> 
      <td> 
        Det datum du vill göra sökningen på. Hittas inga träffar det datumet utvidgas sökningen till andra datum i närheten.
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Invalid format
      </td> 
      <td> 
        Datum måste anges i formatet YYYY-MM-DD eller YYYY-MM-DD HH:MM
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Must be a future timestamp
      </td> 
      <td> 
        Det går inte att söka på datum som redan har varit.
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Required
      </td> 
      <td> 
        Du måste ange ett datum för resan
      </td> 
    </tr> 
    <tr> 
      <td> 
        has_car
      </td> 
      <td> 
         
      </td> 
      <td> 
        Om man letar efter bilplats eller medresenärer. 1 om man har bilplats, 0 om man letar medresenärer.
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Required
      </td> 
      <td> 
        Du måste ange om du har bilplats eller söker en bilplats
      </td> 
    </tr> 
    <tr> 
      <td> 
        name
      </td> 
      <td> 
         
      </td> 
      <td> 
        Annonsörens namn
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Required
      </td> 
      <td> 
        Du måste ange ett namn
      </td> 
    </tr> 
    <tr> 
      <td> 
        email
      </td> 
      <td> 
         
      </td> 
      <td> 
        Annonsörens e-post-adress. Det är hit koden skickas för påminnelse.
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        required
      </td> 
      <td> 
        Du måste ange en e-postadress
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Not valid email
      </td> 
      <td> 
        Du måste ange en e-post-adress enligt korrekt format.
      </td> 
    </tr> 
    <tr> 
      <td> 
        phone
      </td> 
      <td> 
         
      </td> 
      <td> 
         
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        required
      </td> 
      <td> 
        Du måste ange ett telefonnummer
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Invalid format
      </td> 
      <td> 
        Telefonnummer får inte innehålla några bokstäver
      </td> 
    </tr> 
    <tr> 
      <td> 
        details
      </td> 
      <td> 
         
      </td> 
      <td> 
        Detaljer om resan, tillexempel gällande rökning, hundar, packning, var man ska samlas. Hur mycket det kostar osv.
      </td> 
    </tr> 
  </tbody> 
</table> 
 
<h4>Noder</h4> 
 
<table> 
  <tbody> 
    <tr> 
      <td> 
        Nod
      </td> 
      <td> 
        Förklaring
      </td> 
    </tr> 
    <tr> 
      <td> 
        message
      </td> 
      <td> 
        Ett meddelande om att datan är ändrad eller borttagen
      </td> 
    </tr> 
    <tr> 
      <td> 
        new_trip
      </td> 
      <td> 
        Förälder till den nyinlagda resan
      </td> 
    </tr> 
    <tr> 
      <td> 
        trip_id
      </td> 
      <td> 
        Den tillagda resans varje trips unika id-nummer
      </td> 
    </tr> 
    <tr> 
      <td> 
        from_lon
      </td> 
      <td> 
        Longituden man åker ifrån
      </td> 
    </tr> 
    <tr> 
      <td> 
        from_lat
      </td> 
      <td> 
        Latituden man åker ifrån
      </td> 
    </tr> 
    <tr> 
      <td> 
        to_lon
      </td> 
      <td> 
        Longituden man åker till
      </td> 
    </tr> 
    <tr> 
      <td> 
        to_lat
      </td> 
      <td> 
        Latituden man åker till
      </td> 
    </tr> 
    <tr> 
      <td> 
        when
      </td> 
      <td> 
        När resan avgår, i UNIX timestamp
      </td> 
    </tr> 
    <tr> 
      <td> 
        got_car
      </td> 
      <td> 
        Huruvida annonsören har en bil eller söker en bilplats
      </td> 
    </tr> 
    <tr> 
      <td> 
        details
      </td> 
      <td> 
        Detaljer som annonsören har lagt till
      </td> 
    </tr> 
    <tr> 
      <td> 
        inserted
      </td> 
      <td> 
        @lilleman
      </td> 
    </tr> 
    <tr> 
      <td> 
        email
      </td> 
      <td> 
        Annonsörens e-post-adress
      </td> 
    </tr> 
    <tr> 
      <td> 
        from
      </td> 
      <td> 
        Adressen man åker från
      </td> 
    </tr> 
    <tr> 
      <td> 
        to
      </td> 
      <td> 
        Adressen man åker till
      </td> 
    </tr> 
    <tr> 
      <td> 
        phone
      </td> 
      <td> 
        Telefonnummer angett av annonsören
      </td> 
    </tr> 
    <tr> 
      <td> 
        when_iso
      </td> 
      <td> 
        När annonsören vill åka, i unix-timestamp. Om tiden är 00:00 är det antagligen för att annonsören inte angivit någon tid.
      </td> 
    </tr> 
    <tr> 
      <td> 
        code
      </td> 
      <td> 
        Den unika koden för din resa
      </td> 
    </tr> 
  </tbody> 
</table> 
 
<h4>Exempel</h4>
<p>Om vi gör http-anropet
<a href="http://dev.resihop.nu/edittrip?from=Stockholm,+Sverige&amp;to=Göta+älv,+Sweden&amp;when=2010-10-30+00:00&amp;name=Kristoffer+Nolgren&amp;email=kristoffer%40nolgren.se&amp;phone=0704649797&amp;details=tada!&amp;got_car=1&amp;code=924JZ23HR9RT">http://dev.resihop.nu/edittrip?from=Stockholm,+Sverige&amp;to=Göta+älv,+Sweden&amp;when=2010-10-30+00:00&amp;name=Kristoffer+Nolgren&amp;email=kristoffer%40nolgren.se&amp;phone=0704649797&amp;details=tada!&amp;got_car=1&amp;code=924JZ23HR9RT</a> får vi mycket riktigt ett svar med alla detaljer för resan.</p> 
<code>
<pre>
<![CDATA[
<content> 
  <message>Data saved</message> 
  <trip_data> 
    <trip_id>279</trip_id> 
    <from>Stockholm, Sweden</from> 
    <from_lat>18.0645</from_lat> 
    <from_lon>59.3328</from_lon> 
    <to>Göta älv, Sweden</to> 
    <to_lat>12.1229</to_lat> 
    <to_lon>58.0267</to_lon> 
    <when>1288389600</when> 
    <when_iso>2010-10-30 00:00</when_iso> 
    <details>tada!</details> 
    <got_car>1</got_car> 
    <inserted>1288192097</inserted> 
    <name>Kristoffer Nolgren</name> 
    <email>kristoffer@nolgren.se</email> 
    <phone>0704649797</phone> 
  </trip_data> 
</content> 
]]>
</pre>
</code>
<p>Om vi däremot gör http-anropet</p> 
<p><a href="http://dev.resihop.nu/edittrip?remove&amp;code=924JZ23HR9RT">http://dev.resihop.nu/edittrip?remove&amp;code=924JZ23HR9RT</a></p> 
<p>får vi en content nod med innehållet</p> 
<code>
<pre>
<![CDATA[
<content> 
  <message>Data saved</message> 
  <trip_data> 
    <trip_id>279</trip_id> 
    <from>Stockholm, Sweden</from> 
    <from_lat>18.0645</from_lat> 
    <from_lon>59.3328</from_lon> 
    <to>Göta älv, Sweden</to> 
    <to_lat>12.1229</to_lat> 
    <to_lon>58.0267</to_lon> 
    <when>1288389600</when> 
    <when_iso>2010-10-30 00:00</when_iso> 
    <details>tada!</details> 
    <got_car>1</got_car> 
    <inserted>1288192097</inserted> 
    <name>Kristoffer Nolgren</name> 
    <email>kristoffer@nolgren.se</email> 
    <phone>0704649797</phone> 
  </trip_data> 
</content>

 ]]>
</pre>
</code>
<h3>Glömt koden</h3> 
<p>Om man glömt en kod kan man skicka sin e-post adress till resihop. Då skickar resihop ut koden för alla resor kopplade till den e-post-adressen</p> 
 
<h4>HTTP-anrop</h4>
<a href="http://dev.resihop.nu/sendcode">http://dev.resihop.nu/sendcode</a>
<h4>Parametrar och felmeddelanden</h4>
<p>Parametrar med en asterix är obligatoriska.</p> 
 
<table> 
  <tbody> 
    <tr> 
      <td> 
        Parameter
      </td> 
      <td> 
        Felmeddelande
      </td> 
      <td> 
        Förklaring
      </td> 
    </tr> 
    <tr> 
      <td> 
        code
      </td> 
      <td> 
         
      </td> 
      <td> 
        Den unika kod som autencierar förändringar i resan
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Invalid
      </td> 
      <td> 
        E-post-adressen du angivit är inte knuten till någon särskild resa. 
      </td> 
    </tr> 
    <tr> 
      <td> 
         
      </td> 
      <td> 
        Required
      </td> 
      <td> 
        Du måste ange en e-postadress
      </td> 
    </tr> 
  </tbody> 
</table> 
 
<h4>Noder</h4> 
 
<table> 
  <tbody> 
    <tr> 
      <td> 
        Nod
      </td> 
      <td> 
        Förklaring
      </td> 
    </tr> 
    <tr> 
      <td> 
        message
      </td> 
      <td> 
        Ett meddelande om att koden är skickad!
      </td> 
    </tr> 
  </tbody> 
</table> 
 
<h4>Exempel</h4>
<p>Om vi gör http-anropet</p> 
<p><a href="http://dev.resihop.nu/sendcode?kristoffer@nolgren.se">http://dev.resihop.nu/sendcode?kristoffer@nolgren.se</a> får vi ett meddelande om att koden är sänd</p>
<code>
<pre> 
<![CDATA[
<content> 
  <message>Code sent</message> 
</content>
 ]]>
</pre>
</code>
</div>
	</xsl:template>
	<!-- Facebookpage -->
	<xsl:template match="/root/content[../meta/path = 'facebook']">
		<div class="freetext">
		<h2>Samåkningssiter finns det asmånga. Asmånga!</h2>
		<p>Vi bygger en site vars mål är att samla ihop alla samåkningar och göra det väldigt enkelt att dels söka i dem och lägga upp nya. Vår supersmarta sökmotor förstår var adresser ligger, vi lanserade nyss v.2 av resihop. Den har typ 50% färre funktioner än den förra versionen! Tillexempel kan man bland annat lägga till nya resor utan att regga konton och sånt. o/\o</p>

		<p>Vidare är all data offentligt tillgänglig via xml (som datorer älskar (omnomnom)) ifall någon vill bygga någor. Kolla bara källkoden och om ni har några frågor kontakta <a href="mailto:hurbel@yahoo.com">lilleman</a>!</p>
		</div>
	</xsl:template>

</xsl:stylesheet>
