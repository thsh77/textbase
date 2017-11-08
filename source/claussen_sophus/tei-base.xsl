<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs tei" version="2.0">
  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
  <xsl:strip-space elements="*"/>
  <xsl:preserve-space elements="tei:p"/>
  <xsl:template match="node() | @*">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="/">
    <xsl:apply-templates select="tei:TEI"/>
  </xsl:template>
  <xsl:template match="tei:TEI">
    <!--either group or text-->
    <xsl:choose>
      <xsl:when test="tei:group">
        <xsl:apply-templates select="tei:group"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="tei:text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--text part /TEI/text[1]/group[1]/text[1]/group[1]/text[3]/body[1]/div[1]-->
  <xsl:template match="/tei:TEI/tei:text/tei:group/tei:text[1]/tei:group/tei:text[9]/tei:body">
    <xsl:variable name="from-page" select=".//tei:pb/@n"/>
    <xsl:variable name="work-title">
      <xsl:value-of
        select="lower-case(replace((tei:head/normalize-space(string())), ' ', '-'))"/>
    </xsl:variable>
    <xsl:result-document href="claussen_sophus/djavlerier/9/{$work-title}_{generate-id()}.xml">
      <TEI>
        <teiHeader>
          <fileDesc>
            <titleStmt>
              <title>
                <xsl:value-of select="tei:head"/>
              </title>
              <author>
                <xsl:value-of>
                  <xsl:value-of select="//tei:sourceDesc//tei:author//tei:surname"/>, <xsl:value-of
                    select="//tei:sourceDesc//tei:author//tei:forename"/></xsl:value-of>
              </author>
              <editor xml:id="th"/>
            </titleStmt>
            <publicationStmt>
              <publisher>textbase</publisher>
              <pubPlace>Copenhagen</pubPlace>
              <date>
                <xsl:value-of select="current-date()"/>
              </date>
              <idno/>
              <availability status="free">
                <ab>GNU license</ab>
              </availability>
            </publicationStmt>
            <sourceDesc>
              <listWit>
                <witness xml:id="A">empty</witness>
              </listWit>
              <listBibl>
                <bibl>
                  <xsl:copy-of select="//tei:sourceDesc/tei:bibl/*"/>
                  <biblScope>
                    <xsl:value-of select="$from-page"/>
                  </biblScope>
                </bibl>
              </listBibl>
            </sourceDesc>
          </fileDesc>
          <encodingDesc/>
          <profileDesc/>
          <revisionDesc/>
        </teiHeader>
        <text>
          <body>
            <xsl:copy-of select="."/>
          </body>
        </text>
      </TEI>
    </xsl:result-document>
  </xsl:template>
</xsl:stylesheet>
