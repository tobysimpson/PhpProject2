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
                        
                        <th>imp_nuc</th>
                        <th>imp_fos</th>
                        <th>imp_rnw</th>
                        <th>imp_ele</th>
                        <th>imp_dst</th>
                        <th>met_emi</th>
                        <th>met_lnd</th>
                        <th>met_cst</th>
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
                     
                            <td style="text-align:center;">
                                <xsl:value-of select="@rnk_imp_nuc"/>
                            </td>
                            <td style="text-align:center;">
                                <xsl:value-of select="@rnk_imp_fos"/>
                            </td>
                            <td style="text-align:center;">
                                <xsl:value-of select="@rnk_imp_rnw"/>
                            </td>
                            <td style="text-align:center;">
                                <xsl:value-of select="@rnk_imp_ele"/>
                            </td>
                            <td style="text-align:center;">
                                <xsl:value-of select="@rnk_imp_dst"/>
                            </td>
                            <td style="text-align:center;">
                                <xsl:value-of select="@rnk_met_emi"/>
                            </td>
                            <td style="text-align:center;">
                                <xsl:value-of select="@rnk_met_lnd"/>
                            </td>
                            <td style="text-align:center;">
                                <xsl:value-of select="@rnk_met_cst"/>
                            </td>


<!--                            <td style="text-align:right;">
                                <xsl:value-of select="@imp_nuc"/>
                            </td>
                            <td style="text-align:right;">
                                <xsl:value-of select="@imp_fos"/>
                            </td>
                            <td style="text-align:right;">
                                <xsl:value-of select="@imp_rnw"/>
                            </td>
                            <td style="text-align:right;">
                                <xsl:value-of select="@imp_ele"/>
                            </td>
                            <td style="text-align:right;">
                                <xsl:value-of select="@imp_dst"/>
                            </td>
                            
                            <td style="text-align:right;">
                                <xsl:value-of select="@met_emi"/>
                            </td>
                            <td style="text-align:right;">
                                <xsl:value-of select="@met_lnd"/>
                            </td>
                            <td style="text-align:right;">
                                <xsl:value-of select="@met_cst"/>
                            </td>-->
                            
                            <td>
                                <a href="res.php?mth=edt&amp;res_id={@res_id}&amp;xsl=1">res_edt</a>
                            </td>
                            <td>
                                <a href="res.php?mth=prm&amp;res_id={@res_id}&amp;xsl=1">res_prm</a>
                            </td>
                            <td>
                                <a href="res.php?mth=evt&amp;res_id={@res_id}&amp;xsl=1">res_evt</a>
                            </td>
                            <td>
                                <a href="res.php?mth=rnk&amp;res_id={@res_id}&amp;xsl=1">res_rnk</a>
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