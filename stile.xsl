<?xml version="1.0" encoding="UTF-8" standalone="no" ?>
<xsl:stylesheet 
                            xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
				            xmlns:tei="http://www.tei-c.org/ns/1.0" 
				            xmlns="http://www.w3.org/1999/xhtml"
                            version="2.0">
				
	<xsl:output method="html" indent="yes"/>
	
	<xsl:template match="/">
		<html>
            <head>
				<script src="https://code.jquery.com/jquery-3.6.0.js"/>
				<script src="script.js"/>
				<link rel="stylesheet" href="stile.css"/>
				<title> Serena Di Miceli - progetto di CdT </title>
			</head>
			
			<body>
				<header>
					<h1>Rassegna settimanale</h1>
					<h4>di politica, scienze, lettere, ed arti</h4>
                </header>

                <nav>
                    <ul>
                        <li><a href="#TEI-XVsec">Venezia visitata da un frate...</a></li>
                        <li><a href="#TEI-RT">Rassegna tecnologica</a></li>
                        <li><a href="#TEI-AM">Scritti biografici</a></li>
                        <li><a href="#TEI-FL">La monnaie dans l’antiquité...</a></li>
                        <li><a href="#TEI-N">Notizie</a></li>
                    </ul>
                </nav>

                <!-- Contenuto prima dei testi -->
				<xsl:apply-templates select="/tei:teiCorpus/tei:teiHeader"/>
				<xsl:apply-templates select="/tei:teiCorpus/tei:standOff/tei:listPerson"/>
                <xsl:apply-templates select="/tei:teiCorpus/tei:standOff/tei:list[@type='gloss']"/>

                <div id="buttonbox">
                    <h3>Annotazioni</h3>
                    <button id="highlight-button">Mostra tutti gli elementi</button>
                    <button id="highlight-title">Titoli</button>
                    <button id="highlight-persName">Nomi</button>
                    <button id="highlight-places">Siti geografici</button>
                    <button id="highlight-term">Termini</button>
                    <button id="highlight-date">Date</button>
                    <button id="highlight-orgName">Organizzazioni</button>
                    <button id="highlight-eventName">Eventi</button>
                </div>

                <!-- Testi -->
				<main>
                    <xsl:apply-templates select="/tei:teiCorpus/tei:TEI"/>  
                </main>
			</body>
		</html>
	</xsl:template>

    <!-- Edizione digitale -->
	<xsl:template match="tei:respStmt">
        <span class="bold"><xsl:value-of select="tei:resp"/>: </span><xsl:value-of select="tei:persName"/>
        <br/>
    </xsl:template>

    <xsl:template match="tei:editionStmt">
        <span class="bold">Edizione</span>: <xsl:value-of select="tei:edition/tei:date"/>
        <br/>
        <xsl:apply-templates select="tei:respStmt"/>
    </xsl:template>

	<xsl:template match="tei:publicationStmt">
        <span class="bold">Editore</span>: <xsl:value-of select="tei:publisher"/>
        <br/>
        <span class="bold">Disponibilità</span>: <xsl:value-of select="tei:availability"/>
    </xsl:template>

    <!-- Fonte originale -->
    <xsl:template match="tei:sourceDesc/tei:bibl">
        <h2>Fonte originale</h2>
        <xsl:if test="tei:title[@level='a']">  
            <!-- solo gli articoli hanno un titolo -->
            <span class="bold">Titolo dell'articolo: </span> <span class="italic"><xsl:value-of select="tei:title[@level='a']"/></span>
            <br/>
        </xsl:if>
        <xsl:if test="tei:author">
            <!-- solo il primo articolo è firmato -->
            <span class="bold">Autore</span>: <xsl:value-of select="tei:author/tei:persName"/>
            <br/>
        </xsl:if>
        <span class="bold">Titolo della rivista</span>: <span class="italic"><xsl:value-of select="tei:title[@level='j']"/></span>
        <br/>
        <xsl:if test="tei:biblScope">
            <!-- nel teiHeader all'inizio della pagina non ci sono queste informazioni -->
            <span class="bold">Volume</span>: <xsl:value-of select="tei:biblScope[@unit='volume']"/>
            <br/>
            <span class="bold">Fascicolo</span>: <xsl:value-of select="tei:biblScope[@unit='issue']"/>
            <br/>
        </xsl:if>
        <span class="bold">Casa Editrice</span>: <xsl:value-of select="tei:publisher"/>
        <br/>
        <xsl:if test="tei:pubPlace">
            <!-- nel teiHeader all'inizio della pagina non c'è questa informazione -->
            <span class="bold">Luogo di pubblicazione</span>: <xsl:value-of select="tei:pubPlace"/>
            <br/>
        </xsl:if>
        <span class="bold">Anno di pubblicazione</span>: <xsl:value-of select="tei:date"/>
        <br/>
        <xsl:element name="a"> 
            <xsl:attribute name="href"><xsl:value-of select="tei:edition/@source"/></xsl:attribute>Edizione digitale
        </xsl:element> 
        a cura di: 
        <ul>
            <xsl:for-each select="tei:edition/*"> 
                <li><xsl:value-of select="."/></li>
            </xsl:for-each>
        </ul>
    </xsl:template>

    <!-- teiHeader in cima -->
    <xsl:template match="tei:teiHeader">
        <div class="infobox page-header">
            <div class="pageheader-content">
                <h2><xsl:value-of select="tei:fileDesc/tei:titleStmt/tei:title"/></h2>
                <xsl:apply-templates select=".//tei:editionStmt"/>
                <xsl:apply-templates select=".//tei:publicationStmt"/>
            </div>
            <div class="pageheader-content">
                <xsl:apply-templates select=".//tei:sourceDesc/tei:bibl"/>
            </div>
        </div>
    </xsl:template>

    <!-- teiHeader dei testi -->
    <xsl:template match="tei:TEI/tei:teiHeader">
        <div class="article-header">
            <div class="articleheader-content">
                <h2><xsl:value-of select="tei:fileDesc/tei:titleStmt/tei:title"/></h2>
                <xsl:apply-templates select=".//tei:editionStmt"/>
                <xsl:apply-templates select=".//tei:publicationStmt"/> 
            </div>
            <div class="articleheader-content">
                <xsl:apply-templates select=".//tei:sourceDesc/tei:bibl"/>
            </div>
        </div>
    </xsl:template>

    <!-- Testi -->
	<xsl:template match="tei:teiCorpus/tei:TEI">
        <xsl:element name="article">
            <xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute> 
            <xsl:apply-templates select="tei:teiHeader"/>
            <xsl:apply-templates select=".//tei:body"/> 
        </xsl:element>
    </xsl:template>

    <!-- <note> della lista di persone -->
    <xsl:template match="tei:note">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- Lista delle persone -->
    <xsl:template match="tei:standOff/tei:listPerson">
        <div class="infobox">
            <h2>Persone coinvolte nel progetto</h2>
            <xsl:for-each select="tei:person">
                <p class="pers-item"> 
                    <span class="bold">
                        <xsl:element name="span">
                            <xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute> 
                            <xsl:value-of select="tei:persName"/>
                        </xsl:element>
                    </span>
                    <xsl:if test="tei:birth and tei:death">  
                        <!-- non tutte le persone hanno le date di nascita e morte -->
                        (<xsl:value-of select="tei:birth/tei:placeName"/>, <xsl:value-of select="tei:birth/tei:date"/> – <xsl:value-of select="tei:death/tei:placeName"/>, <xsl:value-of select="tei:death/tei:date"/>)
                    </xsl:if>
                    <xsl:apply-templates select="tei:note"/>
                </p>
            </xsl:for-each>
        </div>
    </xsl:template>

    <!-- Glossario -->
	<xsl:template match="tei:standOff/tei:list[@type='gloss']">
        <div class="infobox">
            <h2>Glossario</h2>
            <xsl:for-each select="tei:label">
                <p class="gloss-item">
                    <span class="bold">
                        <xsl:element name="span">
                            <xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
                            <!-- Contenuto di <label> -->
                            <xsl:value-of select="."/> 
                        </xsl:element>
                    </span>: <xsl:value-of select="following-sibling::tei:item[1]"/>
                </p>
            </xsl:for-each>
        </div>
    </xsl:template>

    <!-- Immagini -->
    <xsl:template match="tei:surface">
        <xsl:element name="svg">
            <xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>

            <!-- Coordinate dell'intera immagine -->
            <xsl:attribute name="viewBox">
                <xsl:text>0,</xsl:text> <!-- coordinata x del vertice in alto a sinistra -->
                <xsl:text>0,</xsl:text>  <!-- coordinata y del vertice in alto a sinistra --> 
        
                <!-- Coordinate del vertice in basso a destra -->
                <xsl:value-of select="substring-before(tei:graphic/@width, 'px')"/><xsl:text>,</xsl:text> 
                <!-- <xsl:text>,</xsl:text> inserisce la virgola tra i valori contenuti dentro "viewBox" -->
                <xsl:value-of select="substring-before(tei:graphic/@height, 'px')"/>
                <!-- 
                "substring-before" elimina "px" dalle misure della larghezza e dell'altezza 
                (es: width="1506.4px" >> "1506.4px" è una stringa e "substring-before('1506.4px', 'px')" restituisce quello che c'è prima di "px", ovvero "1506.4")
                -->
            </xsl:attribute>

            <!-- Dimensioni dell'immagine -->
            <xsl:attribute name="width">480</xsl:attribute>
            <xsl:attribute name="height">700</xsl:attribute> 

            <!-- Immagine -->
            <xsl:element name="image">
                <xsl:attribute name="href"><xsl:value-of select="tei:graphic/@url"/></xsl:attribute>

                <!-- Vertice in alto a sinistra: (0,0) -->
                <xsl:attribute name="x"><xsl:value-of select="0"/></xsl:attribute>
                <xsl:attribute name="y"><xsl:value-of select="0"/></xsl:attribute>
                
                <xsl:attribute name="width">100%</xsl:attribute>
                <xsl:attribute name="height">100%</xsl:attribute> 
            </xsl:element>
            
            <!-- Porzioni dell'immagine -->
            <xsl:for-each select="tei:zone">
                <xsl:element name="rect">
                    <xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
                    
                    <!-- Vertice in alto a sinistra -->
                    <xsl:attribute name="x"><xsl:value-of select="@ulx"/></xsl:attribute>
                    <xsl:attribute name="y"><xsl:value-of select="@uly"/></xsl:attribute>

                    <!-- le coordinate del vertice in basso a destra definiscono altezza e larghezza -->
                    <xsl:attribute name="width"><xsl:value-of select="@lrx - @ulx"/></xsl:attribute> <!-- larghezza = differenza tra le ascisse -->
                    <xsl:attribute name="height"><xsl:value-of select="@lry - @uly"/></xsl:attribute> <!-- altezza = differenza tra le ordinate -->
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>

    <!-- Page Beginning  -->
    <xsl:template match="tei:pb">
        <xsl:variable name="pagenumber" select="@n"/> 
        <xsl:apply-templates select="//tei:surface[@xml:id=concat('pg', $pagenumber)]"/> <!-- = "pg+pagenumber" (xml:id = "pg60") -->
    </xsl:template>

    <!-- Header della pagina -->
    <xsl:template match="tei:fw[@type='header']">
        <xsl:element name="div">
            <xsl:attribute name="class">pageheader</xsl:attribute>
            <xsl:attribute name="data-facs"><xsl:value-of select="substring-after(@facs, '#')"/></xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <!-- Parti dell'header della pagina -->
    <xsl:template match="tei:fw/tei:fw">
        <xsl:element name="span">
            <xsl:attribute name="data-facs"><xsl:value-of select="substring-after(@facs, '#')"/></xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <!-- Titolo degli articoli -->
    <xsl:template match="tei:head">
        <xsl:element name="p">
            <xsl:attribute name="class">align-center</xsl:attribute>
            <xsl:attribute name="data-facs"><xsl:value-of select="substring-after(@facs, '#')"/></xsl:attribute>
			<span class="title highlight">
                <span class="h3">
                    <xsl:apply-templates/>
                </span>
            </span>
        </xsl:element >
    </xsl:template>

    <!-- Contenuto dei testi -->
    <xsl:template match="tei:body">
        <xsl:variable name="current-body" select="."/> 
        <xsl:for-each-group select="descendant::node()" group-starting-with="tei:pb"> <!-- il testo viene diviso pagina per pagina -->
            <div class="flexcontainer">
                <div class="column">
                    <xsl:apply-templates select="current-group()[self::tei:fw[@type='header']]"/> <!-- header della pagina -->
                    <xsl:apply-templates select="current-group()[self::tei:pb]"/> <!-- immagine (gestita dal template di tei:pb) --> 
                </div>
                <div class="column">
                    <xsl:apply-templates select="$current-body/(tei:head | tei:bibl | tei:p | tei:list | tei:signed)[descendant-or-self::node() intersect current-group()]"/>
                </div>
            </div>
        </xsl:for-each-group>
    </xsl:template>

    <!-- Entrate bibliografiche -->
    <xsl:template match="tei:body//tei:bibl">
        <xsl:element name="span"> 
            <xsl:attribute name="class">bibl</xsl:attribute>
            <xsl:choose>
                <!-- Sezione Bibliografia -->
                <xsl:when test="@facs">
                    <xsl:attribute name="data-facs"><xsl:value-of select="substring-after(@facs, '#')"/></xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:when>
                <!-- Bibliografie in mezzo al testo -->
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>

    <!-- Paragrafi -->
    <xsl:template match="tei:p">
        <xsl:variable name="current-page" select="current-group()"/>
        <xsl:choose>
            <!-- Paragrafi che si trovano interamente in una colonna della stessa pagina -->
            <xsl:when test="@facs"> <!-- @facs è contenuto in <p> -->
                <xsl:element name="p">
                    <xsl:attribute name="data-facs"><xsl:value-of select="substring-after(@facs, '#')"/></xsl:attribute>
                    <xsl:apply-templates select="node()[descendant-or-self::node() intersect current-group()]"/> <!-- questo current-group contiene la pagina -->
                </xsl:element>
            </xsl:when>
            <!-- Paragrafi che sono divisi tra due pagine o colonne diverse -->
            <xsl:otherwise> <!-- @facs è contenuto in <milestone> --> 
                <xsl:for-each-group select="node()" group-starting-with="tei:milestone"> 
                    <xsl:element name="span">
                        <xsl:attribute name="data-facs"><xsl:value-of select="substring-after(current-group()[self::tei:milestone]/@facs, '#')"/></xsl:attribute>
                        <xsl:apply-templates select="current-group()[not(self::tei:pb | self::tei:fw)] intersect $current-page"/>
                        <!-- <pb> e <fw> sono esclusi perché non devono apparire nella colonna del testo -->
                    </xsl:element>
                </xsl:for-each-group>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Notizie (lista) -->
    <xsl:template match="tei:TEI[@xml:id='TEI-N']//tei:item">
        <p class="small">
            <xsl:attribute name="data-facs"><xsl:value-of select="substring-after(@facs, '#')"/></xsl:attribute>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- Titoli (esclusi quelli delle citazioni) -->
    <xsl:template match="tei:title[not(ancestor::tei:cit)]">
        <xsl:element name="span">
            <xsl:choose>
                <xsl:when test="@rend='italic'">
                    <xsl:attribute name="class">title highlight italic</xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="class">title highlight</xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>

    <!-- Titoli  delle citazioni -->
    <xsl:template match="tei:title[ancestor::tei:cit]">
        <span class="cit-title italic"> <!-- "cit-title" invece di "title" per evitare che i titoli nelle citazioni siano evidenziati --> 
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- Autori collegati alla lista di persone -->
    <xsl:template match="tei:author[not(ancestor::tei:cit)]"> 
        <span class="author">
            <xsl:element name="a"> <!-- collegamento alla lista -->
                <xsl:attribute name="href"><xsl:value-of select="@ref"/></xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </span>
    </xsl:template>

    <!-- Autori nelle citazioni -->
    <xsl:template match="tei:author[ancestor::tei:cit]"> 
        <span class="author">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- Citazioni -->
    <xsl:template match="tei:cit">
        <span class="cit">
            <xsl:apply-templates select="tei:quote"/>
            <xsl:apply-templates select="tei:bibl"/>
        </span>
    </xsl:template>

    <!-- Quotes -->
    <xsl:template match="tei:quote">
        <xsl:element name="span">
            <xsl:choose>
                <xsl:when test="@rend='italic'">
                    <xsl:attribute name="class">quote italic</xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="class">quote</xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>

    <!-- Nomi -->
    <xsl:template match="tei:persName | tei:name | tei:roleName">
        <span class="persName highlight">
            <!-- Nomi che fanno parte della lista di persone -->
            <xsl:choose>
                <xsl:when test="@ref"> <!-- collegamento alla lista -->
                    <xsl:element name="a">
                        <xsl:attribute name="href"><xsl:value-of select="@ref"/></xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:when>
                <!-- Nomi che non fanno parte della lista di persone -->
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>

    <!-- "frate di Ulma" -->
    <xsl:template match="tei:ref[descendant::tei:roleName]">
        <xsl:element name="a">
            <xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute>
            <xsl:attribute name="id">no-link</xsl:attribute>
                <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <!-- Firma -->
    <xsl:template match="tei:signed">
        <xsl:element name="p">
            <xsl:attribute name="class">sign</xsl:attribute>
            <xsl:attribute name="data-facs"><xsl:value-of select="substring-after(@facs, '#')"/></xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <!-- Termini tecnici -->
    <xsl:template match="tei:term[not(descendant::tei:persName)]">
        <xsl:element name="span">
            <xsl:choose>
                <xsl:when test="@rend='italic'">
                    <xsl:attribute name="class">term highlight italic</xsl:attribute> <!-- "perpetui" e "odometro" -->
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="class">term highlight</xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:element name="a"> <!-- collegamento al glossario -->
                <xsl:attribute name="href"><xsl:value-of select="@ref"/></xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <!-- "Microfono di Hughes": sia il termine che il nome sono linkati -->
    <xsl:template match="tei:term[descendant::tei:persName]">
        <span class="term highlight">
            <xsl:element name="a"> <!-- collegamento al glossario -->
                <xsl:attribute name="href"><xsl:value-of select="@ref"/></xsl:attribute>
                <xsl:apply-templates select="tei:hi"/>
            </xsl:element>
            di
            <xsl:apply-templates select="tei:persName"/>
        </span>
    </xsl:template>

    <!-- Siti geografici -->
    <xsl:template match="tei:bloc | tei:country | tei:placeName | tei:geogName">
        <xsl:element name="span">
            <xsl:choose>
                <xsl:when test="@rend='italic'">
                    <xsl:attribute name="class">placeName highlight italic</xsl:attribute> <!-- "orbe" e "torreselle" -->
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="class">placeName highlight</xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <!-- Luoghi collegati al glossario ("Frigia", "orbe", "torreselle", "Pozzi", "Piombi") -->
                <xsl:when test="@ref">
                    <xsl:element name="a"> 
                        <xsl:attribute name="href"><xsl:value-of select="@ref"/></xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>

    <!-- Date -->
    <xsl:template match="tei:date">
        <span class="date highlight"><xsl:apply-templates/></span>
    </xsl:template>

    <!-- Organizzazioni -->
    <xsl:template match="tei:orgName">
        <span class="orgName highlight"><xsl:apply-templates/></span>
    </xsl:template>

    <!-- Eventi -->
    <xsl:template match="tei:eventName">
        <span class="eventName highlight"><xsl:apply-templates/></span>
    </xsl:template>

    <!-- A capo -->
    <xsl:template match="tei:lb" >
        <br/>
    </xsl:template>

    <!-- <hi rend="italic"> -->
    <xsl:template match="tei:hi"> 
        <span class="italic"><xsl:apply-templates/></span>
    </xsl:template>

    <!-- Choice -->
    <xsl:template match="tei:choice">
        <span class="choice">
            <xsl:apply-templates select="tei:abbr"/>
            <xsl:apply-templates select="tei:expan"/>
        </span>
    </xsl:template>

    <!-- Abbreviazioni -->
    <xsl:template match="tei:abbr">
        <span class="abbr"><xsl:apply-templates/></span>
    </xsl:template>
    
    <!-- Estensioni delle abbreviazioni -->
    <xsl:template match="tei:expan">
        <span class="expan"> [<xsl:apply-templates/>]</span> 
    </xsl:template>

</xsl:stylesheet>