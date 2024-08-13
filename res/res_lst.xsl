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
                        <th>res_name</th>
                        <th>res_num</th>
                        
                        <th colspan="2">imp_nuc</th>
                        <th colspan="2">imp_fos</th>
                        <th colspan="2">imp_ele</th>

                        <th colspan="2">met_emi</th>
                        <th colspan="2">met_lnd</th>
                        <th colspan="2">met_cst</th>
                        <th colspan="2">met_avl</th>
                    </tr>
                    <tr>
                        <th></th>
                        <th></th>
                        <th></th>
                        
                        <th>TJ</th>
                        <th>rank</th>
                        <th>TJ</th>
                        <th>rank</th>
                        <th>TJ</th>
                        <th>rank</th>
                        
                        <th>t (mln)</th>
                        <th>rank</th>
                        <th>km<sup>2</sup></th>
                        <th>rank</th>
                        <th>CHF (mln)</th>
                        <th>rank</th>
                        <th>%</th>
                        <th>rank</th>
                    </tr>
                    <xsl:for-each select="tbl[1]/row">
                        <tr>
                            <td style="text-align:center;">
                                <xsl:value-of select="@res_id"/>
                            </td>
                            <td style="text-align:left;">
                                <xsl:value-of select="@res_name"/>
                            </td>
                            <td style="text-align:center;">
                                <xsl:value-of select="@res_num"/>
                            </td>
                     
                            <td style="text-align:right;">
                                <xsl:value-of select="format-number(@imp_nuc,'#,##0')"/>
                            </td>
                            <td style="text-align:center;">
                                <xsl:value-of select="@rnk_imp_nuc"/>
                            </td>
                            
                            <td style="text-align:right;">
                                <xsl:value-of select="format-number(@imp_fos,'#,##0')"/>
                            </td>
                            <td style="text-align:center;">
                                <xsl:value-of select="@rnk_imp_fos"/>
                            </td>
                        
                            <td style="text-align:right;">
                                <xsl:value-of select="format-number(@imp_ele,'#,##0')"/>
                            </td>
                            <td style="text-align:center;">
                                <xsl:value-of select="@rnk_imp_ele"/>
                            </td>
                            
                            
                            
                            <td style="text-align:right;">
                                <xsl:value-of select="format-number(@met_emi,'0.00')"/>
                            </td>
                            <td style="text-align:center;">
                                <xsl:value-of select="@rnk_met_emi"/>
                            </td>
                            <td style="text-align:right;">
                                <xsl:value-of select="format-number(@met_lnd,'0.00')"/>
                            </td>
                            <td style="text-align:center;">
                                <xsl:value-of select="@rnk_met_lnd"/>
                            </td>
                            <td style="text-align:right;">
                                <xsl:value-of select="format-number(@met_cst,'#,##0')"/>
                            </td>
                            <td style="text-align:center;">
                                <xsl:value-of select="@rnk_met_cst"/>
                            </td>
                            <td style="text-align:right;">
                                <xsl:value-of select="format-number(@met_avl,'0.00%')"/>
                            </td>
                            <td style="text-align:center;">
                                <xsl:value-of select="@rnk_met_avl"/>
                            </td>
                        
                 


     
                        <td>
                            <a href="res.php?mth=edt&amp;res_id={@res_id}&amp;xsl=1">res_edt</a>
                        </td>
                        <td>
                            <a href="res.php?mth=prm&amp;res_id={@res_id}&amp;xsl=1">res_prm</a>
                        </td>
                        <td>
                            <a href="res.php?mth=evt&amp;res_id={@res_id}&amp;xsl=1">res_evt</a>
                        </td>

                    </tr>
                    </xsl:for-each> 
                </table>
                <hr/>
                <form action="res.php?mth=ins&amp;xsl=1" method="post">
                    <input type="submit" value="new"/>
                </form>
                
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>