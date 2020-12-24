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
                <link rel="stylesheet" type="text/css" href="hughproject.css" />
                <link rel="stylesheet" type="text/css" href="https://use.typekit.net/jkx1xou.css" />
                <link href="https://fonts.googleapis.com/css2?family=Annie+Use+Your+Telescope&amp;family=Architects+Daughter&amp;family=Caveat:wght@500&amp;family=Fredericka+the+Great&amp;family=IM+Fell+French+Canon+SC&amp;family=Merienda:wght@400;700&amp;family=Montserrat&amp;display=swap" rel="stylesheet"/>
                <!--ebb: The second CSS link line is giving you your handwriting-style font, but you might want to explore some other options that are easier to read on a screen!
                This looks pretty good for the poem titles, but it's hard for the main title (with a series of flourishy capitals in a row),
                and the default size (for the words in the poems) is awfully small. -->
            </head>
            <body>
                <h1><xsl:apply-templates select="descendant::text/title[1]"/></h1>
                <h2>by Langston Hughes</h2>
                <ul class="Nav">
                    <li><a href="index.html" class="active">Home</a></li>
                    <li><a href="separatePoems.html">Reading View</a></li>
                    <li><a href="https://newtfire.org/courses/tutorials/hughesMontage.pdf" target="_blank">Original Manuscript</a></li>
                    <li><a href="about.html">About the Project</a></li>
                    <li><a href="aboutTeam.html">About the Team</a></li>
                    
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
            </body>
        </html>
    </xsl:template>
    <xsl:template match="poem" mode="toc">
        <tr>
            <td><xsl:choose>
                <xsl:when test="not(@cont)"><a href="separatePoems.html#P{count(preceding::poem[not(@cont)])+ 1}"><xsl:apply-templates select="poemTitle"/></a></xsl:when>
                <xsl:otherwise><span class="trouble"><xsl:apply-templates select="poemTitle"/></span></xsl:otherwise>
                </xsl:choose></td>
            <td><a href="separatePoems.html#PG{preceding::pb[1]/@pNum}"><xsl:apply-templates select="preceding-sibling::pb[1]/@pNum"></xsl:apply-templates></a></td>
            <td><xsl:variable name="MD" select="'[Mm]ontage of a [Dd]ream [Dd]eferred'"/>
                <xsl:variable name="DD" select="'[Dd]ream [Dd]eferred'"/>
                <xsl:variable name="D" select="'[Dd]ream'"/>
                <xsl:if test="descendant::line[matches(.,$MD)] or descendant::line[matches(.,$DD)] or descendant::line[matches(.,$D)]">
               <ul class="TOC"><xsl:choose><xsl:when  test="descendant::line[matches(.,$MD)]">
                   <xsl:variable name="Motifmatch" select="descendant::line[matches(.,$MD)][1]"/>
                   <xsl:variable name="PoemTitle" select="$Motifmatch/preceding::poemTitle[string-length() gt 1][1]!tokenize(.,' ')[1]"/>
                   <xsl:variable name="lineNum" select="$Motifmatch/@n"/>
                   <li><a href="separatePoems.html#MD-{$PoemTitle}-{$lineNum}">Montage</a></li>
               </xsl:when>
             <xsl:otherwise><xsl:choose><xsl:when test="descendant::line[matches(.,$DD)]">
                   <xsl:variable name="Motifmatch" select="descendant::line[matches(.,$DD)][1]"/>
                   <xsl:variable name="PoemTitle" select="$Motifmatch/preceding::poemTitle[string-length() gt 1][1]!tokenize(.,' ')[1]"/>
                   <xsl:variable name="lineNum" select="$Motifmatch/@n"/>
                   <li><a href="separatePoems.html#DD-{$PoemTitle}-{$lineNum}">Dream deferred</a></li>
               </xsl:when>
              <xsl:otherwise> <xsl:if test="descendant::line[matches(.,$D)]">
                   <xsl:variable name="Motifmatch" select="descendant::line[matches(.,$D)][1]"/>
                   <xsl:variable name="PoemTitle" select="$Motifmatch/preceding::poemTitle[string-length() gt 1][1]!tokenize(.,' ')[1]"/>
                   <xsl:variable name="lineNum" select="$Motifmatch/@n"/>
                   <li><a href="separatePoems.html#D-{$PoemTitle}-{$lineNum}">Dream</a></li>
               </xsl:if></xsl:otherwise></xsl:choose></xsl:otherwise></xsl:choose></ul>
               </xsl:if>
           </td>
        </tr>
       
    </xsl:template>
</xsl:stylesheet>