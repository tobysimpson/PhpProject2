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
                        <th>res_id</th>
                        <th>prm_id</th>
                        <th>yr</th>
                        <th>tj</th>
                    </tr>
                    <xsl:for-each select="tbl[1]/row">
                        <tr>
                            <td>
                                <xsl:value-of select="@res_id"/>
                            </td>
                            <td>
                                <xsl:value-of select="@prm_id"/>
                            </td>
                            <td style="text-align:right;">
                                <xsl:value-of select="@yr"/>
                            </td>
                            <td style="text-align:right;">
                                <xsl:value-of select="@tj"/>
                            </td>
                            <td> 
                                <a href="prm.php?mth=edt&amp;res_id={@res_id}&amp;prm_id={@prm_id}&amp;xsl=1">edit</a>
                            </td>
                            <td>
                                <a href="prm.php?mth=clr&amp;res_id={@res_id}&amp;prm_id={@prm_id}&amp;yr={@yr}">clear</a>
                            </td>
                        </tr>
                    </xsl:for-each> 
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>