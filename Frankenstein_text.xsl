<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">


    <xsl:template match="tei:teiHeader"/>


    <xsl:template match="tei:body">
        <div class="row">
            <div class="col-3"><br/><br/><br/><br/><br/>
                <xsl:for-each select="//tei:add[@place = 'marginleft']">
                    <xsl:choose>
                        <xsl:when test="parent::tei:del">
                            <del class="{@hand}">
                                <xsl:value-of select="."/>
                            </del><br/>
                        </xsl:when>
                        <xsl:otherwise>
                            <span class="{@hand}">
                                <xsl:value-of select="."/>
                            </span><br/>
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
            <xsl:apply-templates/>
        </div>
    </xsl:template>


    <xsl:template match="tei:head | tei:p">
        <div hand="#MWS">
            <xsl:apply-templates/>
        </div>
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

    <xsl:template match="tei:hi[@rend='doubleUnderline']">
        <span class="doubleUnderline" hand="{@hand}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:hi[@rend='circled']">
        <span class="circled" hand="{@hand}">
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

    <xsl:template match="tei:add[@place='supralinear']">
        <span class="supraAdd" hand="{@hand}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:add[@place='marginleft']">
        <span class="marginAdd" hand="{@hand}" style="font-style: italic;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:add">
        <span class="add" hand="{@hand}" style="font-style: italic;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:del">
        <span class="del" hand="{@hand}" style="font-style: italic;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:list">
        <span class="list" hand="{@hand}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    
</xsl:stylesheet>
