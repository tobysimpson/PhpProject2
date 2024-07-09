<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:php="http://php.net/xsl">
    <xsl:output method="html" encoding="utf-8"/>
    
    <xsl:include href="../nav.xsl"/>
    
    <xsl:template match="/">
        <xsl:call-template name="page"/> 
    </xsl:template>
    


    
    <xsl:template name="fmt">
        <xsl:param name="x"/>
        <xsl:variable name="a" select="translate($x, '-', '')"/>
        <xsl:variable name="d" select="floor(php:function('log10', $a))"/>
        <xsl:variable name="p" select="php:function('pow',10, $d)"/>
<!--        <xsl:value-of select="format-number($x div $p, '0.0000')"/>
        <xsl:text>e</xsl:text>
        <xsl:value-of select="format-number($d,'+00')"/>-->
        <xsl:value-of select="$a"/>
    </xsl:template>

    
    <xsl:template match="root">
        <html>
            <body>
                <table>
                    <tr>
                        <th>item_id</th>
                        <th>item_name</th>
                        <th>item_val1</th>
                        <th>item_val2</th>
                        <th>item_val3</th>
                        <th>item_val4</th>
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
                                <xsl:value-of select="php:function('sprintf','%6.4E', -123.456)"/>
                            </td>
                        </tr>
                    </xsl:for-each> 
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>