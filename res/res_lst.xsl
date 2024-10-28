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
        <xsl:if test="number($x) = number($x)">
            <xsl:value-of select="php:function('sprintf','%6.4e', number($x))"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="root">
        <html>
            <body>
                <table>
                    <tr>
                        <th>res_id</th>
                        <th>res_name</th>
                        <th>res_date</th>
                        <th>res_upd</th>
                        <th>res_yr</th>
                        
<!--                        <th colspan="2">met_nuc</th>
                        <th colspan="2">met_fos</th>
                        <th colspan="2">met_ele</th>

                        <th colspan="2">met_emi</th>
                        <th colspan="2">met_lnd</th>
                        <th colspan="2">met_cst</th>
                        <th colspan="2">met_smr</th>-->
                    </tr>
                    <tr>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        
<!--                        <th>TJ</th>
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
                        <th>rank</th>-->
                    </tr>
                    <xsl:for-each select="tbl[1]/row">
                        <tr>
                            <td style="text-align:center;">
                                
                                <xsl:value-of select="@res_id"/>
                            </td>
                            <td style="text-align:left;">
                                <xsl:value-of select="@res_name"/>
                            </td>
                            
                            <td style="text-align:left;">
                                <xsl:value-of select="@res_date"/>
                            </td>
                            <td style="text-align:left;">
                                <xsl:value-of select="@res_upd"/>
                            </td>
                            
                            <td style="text-align:center;">
                                <xsl:value-of select="@res_yr"/>
                            </td>
                     
<!--                            <td style="text-align:right;">
                                <xsl:call-template name="fmt">
                                    <xsl:with-param name="x" select="@met_nuc"/>
                                </xsl:call-template>
                            </td>
                            <td style="text-align:center;">
                                <xsl:value-of select="@rnk_nuc"/>
                            </td>
                            
                            <td style="text-align:right;">
                                <xsl:call-template name="fmt">
                                    <xsl:with-param name="x" select="@met_fos"/>
                                </xsl:call-template>
                            </td>
                            <td style="text-align:center;">
                                <xsl:value-of select="@rnk_fos"/>
                            </td>
                        
                            <td style="text-align:right;">
                                <xsl:call-template name="fmt">
                                    <xsl:with-param name="x" select="@met_ele"/>
                                </xsl:call-template>
                            </td>
                            <td style="text-align:center;">
                                <xsl:value-of select="@rnk_ele"/>
                            </td>
                            
                            
                            
                            <td style="text-align:right;">
                                <xsl:call-template name="fmt">
                                    <xsl:with-param name="x" select="@met_emi"/>
                                </xsl:call-template>
                            </td>
                            <td style="text-align:center;">
                                <xsl:value-of select="@rnk_emi"/>
                            </td>
                            <td style="text-align:right;">
                                <xsl:call-template name="fmt">
                                    <xsl:with-param name="x" select="@met_lnd"/>
                                </xsl:call-template>
                            </td>
                            <td style="text-align:center;">
                                <xsl:value-of select="@rnk_lnd"/>
                            </td>
                            <td style="text-align:right;">
                                <xsl:call-template name="fmt">
                                    <xsl:with-param name="x" select="@met_cst"/>
                                </xsl:call-template>
                            </td>
                            <td style="text-align:center;">
                                <xsl:value-of select="@rnk_cst"/>
                            </td>
                            <td style="text-align:right;">
                                <xsl:call-template name="fmt">
                                    <xsl:with-param name="x" select="@met_smr"/>
                                </xsl:call-template>
                            </td>
                            <td style="text-align:center;">
                                <xsl:value-of select="@rnk_smr"/>
                            </td>
                        -->
                 
                            <td>
                                <a href="res.php?mth=edt&amp;res_id={@res_id}&amp;xsl=1">res_edt</a>
                            </td>

                            <td>
                                <a href="res.php?mth=evt&amp;res_id={@res_id}&amp;xsl=1">res_evt</a>
                            </td>
                            <td>
                                <a href="res.php?mth=rnk&amp;res_id={@res_id}&amp;xsl=1">res_rnk</a>
                            </td>
                            <td>
                                <a href="res.php?mth=grp&amp;res_id={@res_id}&amp;xsl=1">res_grp</a>
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