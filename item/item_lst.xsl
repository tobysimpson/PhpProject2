<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:php="http://php.net/xsl"
                xmlns:exsl="http://exslt.org/common"
                extension-element-prefixes="exsl">
    <xsl:output method="html" encoding="utf-8"/>
    
    <xsl:include href="../nav.xsl"/>
    
    <xsl:template match="/">
        <xsl:call-template name="page"/> 
    </xsl:template>
    
    <xsl:template name="test1">
        <xsl:param name="nodes" />
  
        <xsl:element name="dat">
            <xsl:for-each select="$nodes">
                <xsl:sort select="." data-type="number" order="ascending"/>
                <xsl:if test="position()=1">
                    <xsl:attribute name="min">
                        <xsl:value-of select="."/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="position()=last()">
                    <xsl:attribute name="max">
                        <xsl:value-of select="."/>
                    </xsl:attribute>
                </xsl:if>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
    
    
    <xsl:variable name="nodes" select="root/tbl[1]/row/@item_id"/>

    <xsl:variable name="zz" select="'0.0000000000000000000'"/>
    
    <xsl:variable name="fmts">
        <fmt dp="0" val="0"/>
        <fmt dp="1" val="0.0"/>
        <fmt dp="2" val="0.00"/>
        <fmt dp="3" val="0.000"/>
        <fmt dp="4" val="0.0000"/>
    </xsl:variable>
    

    <xsl:variable name="data">
        <xsl:call-template name="test1">
            <xsl:with-param name="nodes" select="$nodes" />
        </xsl:call-template>
    </xsl:variable>
    
    
    <xsl:template match="root">
        <html>
            <body>
                

                <!--                
                    <xsl:element name="dat">
                        <xsl:for-each select="$nodes">
                            <xsl:sort select="." data-type="number" order="ascending"/>
                            <xsl:if test="position()=1">
                                <xsl:attribute name="min">
                                    <xsl:value-of select="."/>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:if test="position()=last()">
                                <xsl:attribute name="max">
                                    <xsl:value-of select="."/>
                                </xsl:attribute>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:variable>
             
                <xsl:copy-of select="$data"/> -->
               
                <xsl:value-of select="exsl:node-set($data)/dat/@min"/>
                <xsl:value-of select="exsl:node-set($data)/dat/@max"/>


                
                
                <table>
                    <tr>
                        <th>item_id</th>
                        <th>item_name</th>
                    </tr>
                    <xsl:for-each select="tbl[1]/row">
                        <tr>
                            <td>
                                <xsl:value-of select="@item_id"/>
                            </td>
                            <td style="text-align:left;">
                                <xsl:value-of select="@item_name"/>
                            </td>
                            <td>
                                <xsl:value-of select="php:function('pow',10,number(@item_id))"/>
                            </td>
                            <td>
                                <xsl:value-of select="exsl:node-set($fmts)/fmt[@dp=3]/@val"/>
                            </td>
                            <td>
                                <xsl:value-of select="format-number(123.45678,exsl:node-set($fmts)/fmt[@dp=3]/@val)"/>
                            </td>
                            <td>
                                <xsl:value-of select="format-number(123.45678,substring($zz,1,4))"/>
                            </td>
                        </tr>
                    </xsl:for-each> 
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>