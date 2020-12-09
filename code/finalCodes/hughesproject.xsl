<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
 <!--2020-12-04 ebb: This XSLT models xsl:analyze string, while outputting a reading view of the Montage of a Dream Deferred poetry collection.
The xsl:analyze-string code is matching on a text() node, any text() node, and it is designed to match
on the phrase "dream deferred" to output it in an HTML <span class="motif"> which can be styled to highlight 
any time this phrase is used anywhere the poetry collection.
 -->   
    <xsl:template match="/">
        <html>
            <head>
                <title>Montage of A Dream Deferred</title>
                <link rel="stylesheet" type="text/css" href="hughproject.css"/>
                <link rel="stylesheet" type="text/css" href="https://use.typekit.net/jkx1xou.css" />
                <!--ebb: The second CSS link line is giving you your handwriting-style font, but you might want to explore some other options that are easier to read on a screen!
                This looks pretty good for the poem titles, but it's hard for the main title (with a series of flourishy capitals in a row),
                and the default size (for the words in the poems) is awfully small. -->
            </head>
            <body>
                <h1><xsl:apply-templates select="descendant::text/title[1]"/></h1>
                <!--It looks like you have two title elements, one way at the end of the document? So this one just catches the first one. -->
                <h2>by Langston Hughes</h2>
                <ul> <!-- jkc: Navigation Bar -->
                    <li><a href="index.html">Home</a></li>
                    <li><a href="about.html">About the Project</a></li>
                    <li><a href="aboutTeam.html">About the Team</a></li>
                    <li><a href="hughesBio.html">About Langston Hughes</a></li>
                </ul>
                <!--jkc:Table of Contents -->
                <section id="contents"> <table> 
                    <tr>
                        <th>Poem</th>
                        <th>Page Number</th>
                    </tr>
                    <xsl:apply-templates select="descendant::poem" mode="toc"/>
                    
                </table></section>
                <hr/>
                <!-- jkc: the actual poems -->
                <section id="readingView">
                    <xsl:apply-templates select="descendant::div[@xml:id='epigraph']"/>
                    <xsl:apply-templates select="descendant::div[@xml:id='everypoem']"/>
                </section>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="poem" mode="toc">
       <xsl:if test="not(@cont)"><tr>
            <td><a href="#P{count(preceding::poem[not(@cont)])+ 1}"><xsl:apply-templates select="poemTitle"/></a></td>
           <td><a href="#PG{preceding-sibling::pb[1]/@pNum}"><xsl:apply-templates select="preceding-sibling::pb[1]/@pNum"></xsl:apply-templates></a></td>
        </tr></xsl:if>
    </xsl:template>
<!--2020-12-04 ebb: This template matches on text() nodes anywhere in your source XML, and analyzes them
    looking for the regex pattern "dream deferred", as a literal phrase. Anytime it finds those characters all together,
    it outputs an HTML <span class="motif">...</span> around the matching part, and it also outputs the non-matching part.
    -->   
    <!-- ebb: You could create as many of these as you like, but you have to set them in order and nest them like I did here, so I could pick up either capital or lower-case "Freedom" or "freedom" as well as "dream deferred". 
        And, of course, you can style your output <span> elements with CSS, maybe with colors or background colors or text-decoration effects
        .-->
    <xsl:template match="div[@xml:id='epigraph']">
        <xsl:apply-templates select="poem"/>
    </xsl:template>
    <xsl:template match="pb">
        <p class="pageNum" id="PG{@pNum}"><xsl:apply-templates select="@pNum"/></p>
    </xsl:template>
    <xsl:template match="format">
        <xsl:variable name="formatProperty" as="xs:string+" select="@*/string()"/>
        <em class="{$formatProperty}"><xsl:apply-templates/></em> 
    </xsl:template>
    <!-- jkc: trying to add internal links -->
    <xsl:template match="poem">
        <xsl:choose>
            <xsl:when test="@cont"><h2><xsl:apply-templates select="poemTitle"/></h2></xsl:when>
            <xsl:otherwise><h2 id="P{count(preceding::poem[not(@cont)])+ 1}"><xsl:apply-templates select="poemTitle"/></h2></xsl:otherwise>
        </xsl:choose>
        <br/><p><xsl:apply-templates select="child::note"/></p>
        <xsl:apply-templates select="descendant::stanza"/> 
    </xsl:template>
    <xsl:template match = "stanza"> 
        <section class = "stanza">
            <xsl:apply-templates select ="line"/>
        </section>
    </xsl:template>
    <xsl:template match = "line">
        <div class = "line"><span class = "lineNum"> 
            <xsl:apply-templates select = "@n"/>
        </span> <xsl:apply-templates/></div>
    </xsl:template>
</xsl:stylesheet>