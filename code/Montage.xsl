<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Montage of a Dream Deferred</title>
                <link rel="stylesheet" type="text/css" href="montageStyle.css"/>
                <!--ebb: Change the above to your CSS file! -->
            </head>
            <body>
                <xsl:apply-templates select="descendant::poem[following-sibling::title]"/>
                
                <h1><xsl:apply-templates select="descendant::title"/></h1>
                <h2>by Langston Hughes</h2>
                
                <xsl:apply-templates select="descendant::poem[preceding-sibling::title]"/> 
                
            </body>
        </html>      
    </xsl:template>
    
    <xsl:template match="poem">
        <xsl:if test="poemTitle">
            <h3><xsl:apply-templates select="poemTitle !
       normalize-space()"/></h3>
        </xsl:if>
        <section id = "{poemTitle ! translate(.,' ','')}{position()}"><xsl:apply-templates select = "body"/></section>     
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
     
    <xsl:template match = "format[@wordType = 'italics']">
         <span class = "italics"> 
             <xsl:apply-templates/></span>
         
        
     </xsl:template>
   
    
</xsl:stylesheet>