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
                        <th>prm_id</th>
                        <th>par_id</th>
                        <th>prm_depth</th>
                        <th>prm_path_code</th>
                        <th>prm_desc</th>
                        <th>reg_a</th>
                        <th>reg_b</th>
                        <th>prm_def</th>
                    </tr>
                    <xsl:for-each select="tbl[1]/row">
                        <tr>
                            <td style="text-align:center">
                                <xsl:value-of select="@prm_id"/>
                            </td>
                            <td style="text-align:center">
                                <xsl:value-of select="@par_id"/>
                            </td>
                            <td style="text-align:center">
                                <xsl:value-of select="@prm_depth"/>
                            </td>
                            <td>
                                <xsl:value-of select="@prm_path_code"/>
                            </td>
                            <td>
                                <xsl:value-of select="@prm_desc"/>
                            </td>
                            <td style="text-align:right">
                                <xsl:value-of select="@reg_a"/>
                            </td>
                            <td style="text-align:right">
                                <xsl:value-of select="@reg_b"/>
                            </td>
                            <td style="text-align:right">
                                <xsl:value-of select="@prm_def"/>
                            </td>
                            <td>
                                <xsl:if test="@reg_a!=''">
                                    <a href="prm.php?mth=hst&amp;prm_id={@prm_id}&amp;xsl=1">prm_hst</a>
                                </xsl:if>
                            </td>
                        </tr>
                    </xsl:for-each> 
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>