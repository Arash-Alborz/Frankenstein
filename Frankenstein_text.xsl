<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <!-- <xsl:output method="xml" omit-xml-declaration="yes" indent="yes" /> -->
    <xsl:template match="tei:teiHeader"/>

    <xsl:template match="tei:body">
        <div class="row">
        <div class="col-3"><br/><br/><br/><br/><br/>
            <xsl:for-each select="//tei:add[@place = 'marginleft']">
                <xsl:choose>
                    <xsl:when test="parent::tei:del">
                        <del>
                            <xsl:attribute name="class">
                                <xsl:value-of select="attribute::hand" />
                            </xsl:attribute>
                            <xsl:value-of select="."/></del><br/>
                    </xsl:when>
                    <xsl:otherwise>
                        <span >
                            <xsl:attribute name="class">
                                <xsl:value-of select="attribute::hand" />
                            </xsl:attribute>
                        <xsl:value-of select="."/><br/>
                        </span>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each> 
        </div>
        <div class="col-9">
            <div class="transcription">
                <xsl:apply-templates select="//tei:div"/>
            </div>
        </div>
        </div> 
    </xsl:template>
    
    <xsl:template match="tei:div">
        <div class="#MWS">
            <xsl:apply-templates/></div>
    </xsl:template>
    <xsl:template match="tei:head">
    <div hand="#MWS">
        <xsl:apply-templates/>
    </div>
    </xsl:template>
    
    <xsl:template match="tei:p">
    <p hand="#MWS">
        <xsl:apply-templates/>
    </p>
    </xsl:template>

    <xsl:template match="tei:hi[@rend='supralinear']">
    <span class="supraAdd" style="vertical-align: super;">
        <xsl:apply-templates/>
    </span>
    </xsl:template>

    <xsl:template match="tei:hi[@rend='underline']">
    <span class="underline">
        <xsl:apply-templates/>
    </span>
    </xsl:template>

    <xsl:template match="tei:metamark[@function='pagenumber']">
        <div class="right-align">
            <span class="circled" hand="{tei:num/@hand}">
                <xsl:value-of select="tei:num"/>
            </span>
        </div>
    </xsl:template>

    <xsl:template match="tei:hi[@rend='circled']">
    <div class="right-align">  <!-- Added div with right-align for page number -->
        <span class="circled" hand="{@hand}">
            <xsl:value-of select="."/>
        </span>
    </div>
    </xsl:template>

    <xsl:template match="tei:hi[@rend='circled']">
    <span class="circled" hand="{@hand}">
        <xsl:apply-templates/>
    </span>
    </xsl:template>
    
    <xsl:template match="tei:del">
        <del>
            <xsl:attribute name="class">
                <xsl:value-of select="@hand"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </del>
    </xsl:template>
    <xsl:template match="tei:hi[@rend='underline']">
    <span class="underline" hand="{@hand}">
        <xsl:apply-templates/>
    </span>
    </xsl:template>
        <xsl:template match="tei:hi[@rend='doubleUnderline']">
    <span class="doubleUnderline" hand="{@hand}">
        <xsl:apply-templates/>
    </span>
    </xsl:template>
    
    
    <!-- all the supralinear additions are given in a span with the class supraAdd, make sure to put this class in superscript in the CSS file, -->
    <xsl:template match="tei:add[@place = 'supralinear']">
        <span class="supraAdd" hand="{@hand}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:add[@place = 'marginleft']">
        <span class="marginAdd" hand="{@hand}" style="font-style: italic;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:del">
    <span class="change del">
        <xsl:apply-templates/>
    </span>
    </xsl:template>

    <xsl:template match="tei:add">
    <span class="add" hand="{@hand}" style=" font-style: italic;">
        <xsl:apply-templates/>
    </span>
    </xsl:template>

    <xsl:template match="tei:del">
        <span class="del" hand="{@hand}" style=" font-style: italic;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:add[@place='supralinear']">
        <span class="supraAdd" hand="{@hand}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- add additional templates below, for example to transform the tei:lb in <br/> empty elements, tei:hi[@rend = 'sup'] in <sup> elements, the underlined text, additions with the attribute "overwritten" etc. -->
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    
</xsl:stylesheet>
