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
                <h2>by Langston Hughes</h2>
                <ul> <!-- jkc: Navigation Bar -->
                    <li><a href="index.html">Home</a></li>
                    <li><a href="about.html">About the Project</a></li>
                    <li><a href="aboutTeam.html">About the Team</a></li>
                    <li><a href="hughesbio.html">About Langston Hughes</a></li>
                    <li><a href="https://newtfire.org/courses/tutorials/hughesMontage.pdf">Original Manuscript</a></li>
                </ul>
                <!--jkc:Table of Contents -->
                <section id="contents"> <table> 
                    <tr>
                        <th>Poem</th>
                        <th>Page Number</th>
                        <th>Motifs</th>
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
           <td><xsl:apply-templates select="descendant::note"></xsl:apply-templates></td>
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
        <div class="line"><span class = "lineNum"> 
            <xsl:apply-templates select = "@n"/>
        </span> <xsl:apply-templates/></div>
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