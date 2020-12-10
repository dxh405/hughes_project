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
                <link rel="stylesheet" type="text/css" href="poems.css"/>
                <link rel="stylesheet" type="text/css" href="https://use.typekit.net/jkx1xou.css" />
            </head>
            <body>
                <h1><xsl:apply-templates select="descendant::text/title[1]"/></h1>
                <h2>by Langston Hughes</h2>
                <ul> <!-- jkc: Navigation Bar -->
                    <li><a href="index.html">Home</a></li>
                    <li><a href="about.html">About the Project</a></li>
                    <li><a href="aboutTeam.html">About the Team</a></li>
                    <li><a href="hughesbio.html">About Langston Hughes</a></li>
                    <li><a href="https://newtfire.org/courses/tutorials/hughesMontage.pdf">Original Manuscript</a></li>
                </ul>
                <hr/>
                <!-- jkc: the actual poems -->
                <section id="readingView">
                    <xsl:apply-templates select="descendant::div[@xml:id='epigraph']"/>
                    <xsl:apply-templates select="descendant::div[@xml:id='everypoem']"/>
                </section>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="div[@xml:id='epigraph']">
        <div class="pageNum" id="PG{child::pb[@pNum]}"><xsl:apply-templates select="preceding-sibling::pb[@pNum]"/></div><!-- jkc: the page number here doesn't work. -->
        <xsl:apply-templates select="poem"/>
    </xsl:template>
    <xsl:template match="pb">
            <div class="pageNum" id="PG{@pNum}"><xsl:apply-templates select="@pNum"/></div>
    </xsl:template>
    <xsl:template match="format">
        <xsl:variable name="formatProperty" as="xs:string+" select="@*/string()"/>
        <em class="{$formatProperty}"><xsl:apply-templates/></em> 
    </xsl:template>
    <!-- jkc: trying to add internal links -->
    <xsl:template match="poem">
        <xsl:if test="not(@cont)">
            <h2 id="P{count(preceding::poem[not(@cont)])+ 1}"><xsl:apply-templates select="poemTitle"/></h2>
           <!-- jkc: I want to make it so that if it has @cont, it doesn't show up -->
        </xsl:if>
        <xsl:choose><xsl:when test="@note"><br/><p><xsl:apply-templates select="child::note"/></p></xsl:when></xsl:choose>
        <xsl:apply-templates select="descendant::stanza"/> 
    </xsl:template>
    <xsl:template match="stanza"> 
        <section class="stanza">
            <xsl:apply-templates select ="line"/>
        </section>
    </xsl:template>
    <xsl:template match="line">
        <span class = "lineNum"><xsl:apply-templates select = "@n"/><div class="line">
         <xsl:apply-templates/></div></span>
    </xsl:template>
    <!-- jkc: highlighting the montage parts -->
    <xsl:template match="body/descendant::note[@ref='dream']">
        <em class="bluelight"><xsl:apply-templates/></em>
    </xsl:template>
    <xsl:template match="text()">
        <xsl:analyze-string select="." regex="dream deferred">
            <xsl:matching-substring> 
                <span class="motif"><xsl:value-of select="."/></span>
            </xsl:matching-substring>
            
            <xsl:non-matching-substring>
                <xsl:analyze-string select="." regex="[Ff]reedom"><!--ebb: I kept on going here to see if I could keep adding highlights to other phrases. This is how you do it.
                Set a new xsl: analyze string inside the non-matching substring, and keep on going, so each new one nests inside the non-matching substring of the previous analyze-string.-->
                    <xsl:matching-substring>
                        <span class="motif"><xsl:value-of select="."/></span>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <xsl:value-of select="."/>
                    </xsl:non-matching-substring>
                </xsl:analyze-string>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
        
    </xsl:template>
</xsl:stylesheet>