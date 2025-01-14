<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <!-- <xsl:output method="xml" omit-xml-declaration="yes" indent="yes" /> -->

    
    <xsl:template match="tei:TEI">
                     <div class="row">
                         <div class="col">
                             <h5>About the manuscript page:</h5>
                             <xsl:value-of select="//tei:sourceDesc"/>
                             <xsl:value-of select="//tei:licence"/> <!-- You can change the way the metadata is visualised as well-->
                         </div>
                         <div class="col">
                            <ul> 
                                <li>Total number of words:
                                <xsl:variable name="text" select="normalize-space(string(//tei:body))" />
                                <xsl:value-of select="string-length($text) - string-length(translate($text, ' ', '')) + 1" />
                                </li>
                                <li>Total number of modifications: 
                                    <xsl:value-of select="count(//tei:del|//tei:add)" />
                                </li>
                                <li>Modifications by Mary Shelley:
                                <xsl:value-of select="count(//tei:add[@hand='#MWS'] | //tei:del[@hand='#MWS'])" />
                                </li>
                                <li>Modifications by Percy Shelley:
                                <xsl:value-of select="count(//tei:add[@hand='#PBS'] | //tei:del[@hand='#PBS'])" />
                                </li>
                                <li>Number of additions: 
                                <xsl:value-of select="count(////tei:add)" />
                                </li>
                                 <li>Number of deletions: 
                                <xsl:value-of select="count(////tei:del)" />
                                </li>
                                
                                </li>
                            </ul>
                        </div>
                     </div>
        <hr/>
    </xsl:template>
    

</xsl:stylesheet>
