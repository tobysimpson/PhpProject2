<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="utf-8"/>
    
    <xsl:include href="../nav.xsl"/>
    
    <xsl:template match="/">
        <xsl:call-template name="page"/> 
    </xsl:template>
    
    <xsl:template match="root">
        <html>
            <body>
                <table>
                    <tr>
                        <th>id</th>
                        <th>name</th>
                    </tr>
                    <xsl:for-each select="tbl[1]/row">
                        <tr>
                            <td>
                                <xsl:value-of select="@item_id"/>
                            </td>
                            <td style="text-align:left;">
                                <xsl:value-of select="@item_name"/>
                            </td>
                        </tr>
                    </xsl:for-each> 
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>