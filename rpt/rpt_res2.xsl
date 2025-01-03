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
                        
                        <th>res_frm</th>
                        <th>res_trt</th>
                        <th>res_lng</th>
                        <th>res_tok</th>
                        
                        
                        <th>met_nuc</th>
                        <th>met_fos</th>
                        <th>met_ele</th>
                        <th>met_emi</th>
                        <th>met_lnd</th>
                        <th>met_cst</th>
                        <th>met_smr</th>
                        
                        <th>cap_gas</th>
                        <th>cap_nuc</th>
                        <th>cap_riv</th>
                        <th>cap_res</th>
                        <th>cap_wst</th>
                        <th>cap_woo</th>
                        <th>cap_bgs</th>
                        <th>cap_sol</th>
                        <th>cap_wnd</th>
                        <th>cap_ccs</th>
                 
                        
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
                            
                            <td style="text-align:center;">
                                <xsl:value-of select="@res_frm"/>
                            </td>
                            <td style="text-align:center;">
                                <xsl:value-of select="@res_trt"/>
                            </td>
                            <td style="text-align:center;">
                                <xsl:value-of select="@res_lng"/>
                            </td>
                            <td style="text-align:left;">
                                <xsl:value-of select="@res_tok"/>
                            </td>
                            
                            
                            <td style="text-align:right;">
                                <xsl:call-template name="fmt">
                                    <xsl:with-param name="x" select="@met_nuc"/>
                                </xsl:call-template>
                            </td>
                            <td style="text-align:right;">
                                <xsl:call-template name="fmt">
                                    <xsl:with-param name="x" select="@met_fos"/>
                                </xsl:call-template>
                            </td>
                            <td style="text-align:right;">
                                <xsl:call-template name="fmt">
                                    <xsl:with-param name="x" select="@met_ele"/>
                                </xsl:call-template>
                            </td>
                            <td style="text-align:right;">
                                <xsl:call-template name="fmt">
                                    <xsl:with-param name="x" select="@met_emi"/>
                                </xsl:call-template>
                            </td>
                            <td style="text-align:right;">
                                <xsl:call-template name="fmt">
                                    <xsl:with-param name="x" select="@met_lnd"/>
                                </xsl:call-template>
                            </td>
                            <td style="text-align:right;">
                                <xsl:call-template name="fmt">
                                    <xsl:with-param name="x" select="@met_cst"/>
                                </xsl:call-template>
                            </td>
                            <td style="text-align:right;">
                                <xsl:call-template name="fmt">
                                    <xsl:with-param name="x" select="@met_smr"/>
                                </xsl:call-template>
                            </td>
                         
                            
                            
                            
                            <td align="right">
                                <xsl:call-template name="fmt">
                                    <xsl:with-param name="x" select="@cap_gas"/>
                                </xsl:call-template>
                            </td>
                            <td align="right">
                                <xsl:call-template name="fmt">
                                    <xsl:with-param name="x" select="@cap_nuc"/>
                                </xsl:call-template>
                            </td>
                            <td align="right">
                                <xsl:call-template name="fmt">
                                    <xsl:with-param name="x" select="@cap_riv"/>
                                </xsl:call-template>
                            </td>
                            <td align="right">
                                <xsl:call-template name="fmt">
                                    <xsl:with-param name="x" select="@cap_res"/>
                                </xsl:call-template>
                            </td>
                            <td align="right">
                                <xsl:call-template name="fmt">
                                    <xsl:with-param name="x" select="@cap_wst"/>
                                </xsl:call-template>
                            </td>
                            <td align="right">
                                <xsl:call-template name="fmt">
                                    <xsl:with-param name="x" select="@cap_woo"/>
                                </xsl:call-template>
                            </td>
                            <td align="right">
                                <xsl:call-template name="fmt">
                                    <xsl:with-param name="x" select="@cap_bgs"/>
                                </xsl:call-template>
                            </td>
                            <td align="right">
                                <xsl:call-template name="fmt">
                                    <xsl:with-param name="x" select="@cap_sol"/>
                                </xsl:call-template>
                            </td>
                            <td align="right">
                                <xsl:call-template name="fmt">
                                    <xsl:with-param name="x" select="@cap_wnd"/>
                                </xsl:call-template>
                            </td>
                            <td align="right">
                                <xsl:call-template name="fmt">
                                    <xsl:with-param name="x" select="@cap_ccs"/>
                                </xsl:call-template>
                            </td>

                            
                         
                            <!--<td style="text-align:left;white-space: nowrap;">
                                <xsl:value-of select="@res_json"/>
                            </td>-->

                        </tr>
                    </xsl:for-each> 
                </table>

            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>