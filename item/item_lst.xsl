<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:php="http://php.net/xsl">
    <xsl:output method="html" encoding="utf-8"/>
    
    <xsl:include href="../nav.xsl"/>
    
    <xsl:template match="/">
        <xsl:call-template name="page"/> 
    </xsl:template>
    

    
    <xsl:template match="root">
        <html>
            <head>
            </head>
            <body onload="console.log(window.location.search);">
                <table>
                    <tr>
                        <th>item_id</th>
                        <th>item_name</th>
                        <th>item_val</th>
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
                                <xsl:value-of select="php:function('sprintf','%6.4E', @item_val)"/>
                            </td>
                        </tr>
                    </xsl:for-each> 
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>