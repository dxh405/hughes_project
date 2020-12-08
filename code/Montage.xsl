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