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
                        <th>grp_id</th>
                        <th>prc_id</th>
                        <th>prd_id</th>
                        
                        <th>prm_code</th>
                        <th>grp_name</th>
                        <th>prc_name</th>
                        <th>prd_name</th>
                        
                        <th>reg_a</th>
                        <th>reg_b</th>
                        <th>prm_grw</th>
                        <th>prm_cal</th>
                        <th>prm_eff</th>
                    </tr>
                    <xsl:for-each select="tbl[1]/row">
                        <tr>
                            <td style="text-align:center">
                                <xsl:value-of select="@prm_id"/>
                            </td>
                            <td style="text-align:center">
                                <xsl:value-of select="@grp_id"/>
                            </td>
                            <td style="text-align:center">
                                <xsl:value-of select="@prc_id"/>
                            </td>
                            <td style="text-align:center">
                                <xsl:value-of select="@prd_id"/>
                            </td>

                            
                            <td style="text-align:left">
                                <xsl:value-of select="@prm_code"/>
                            </td>
                            <td style="text-align:left">
                                <xsl:value-of select="@grp_name"/>
                            </td>
                            <td style="text-align:left">
                                <xsl:value-of select="@prc_name"/>
                            </td>
                            <td style="text-align:left">
                                <xsl:value-of select="@prd_name"/>
                            </td>
                            
                            
                            
                            <td style="text-align:right">
                                <xsl:value-of select="@reg_a"/>
                            </td>
                            <td style="text-align:right">
                                <xsl:value-of select="@reg_b"/>
                            </td>
                            
                            <td style="text-align:center">
                                <xsl:value-of select="@prm_grw"/>
                            </td>
                            <td style="text-align:center">
                                <xsl:value-of select="@prm_cal"/>
                            </td>
                            <td style="text-align:right">
                                <xsl:if test="number(@prm_eff) = @prm_eff">
                                    <xsl:value-of select="format-number(@prm_eff,'0.0000')"/>
                                </xsl:if>
                            </td>
                            
                            
                            <td>
                                <xsl:if test="@reg_a!=''">
                                    <a href="prm.php?mth=hst&amp;prm_id={@prm_id}&amp;xsl=1">prm_hst</a>
                                </xsl:if>
                            </td>
                            <td>
                                <xsl:if test="number(@prm_eff) &gt; 0">
                                    <a href="prm.php?mth=eff&amp;prm_id={@prm_id}&amp;xsl=1">prm_eff</a>
                                </xsl:if>
                            </td>
                        </tr>
                    </xsl:for-each> 
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>