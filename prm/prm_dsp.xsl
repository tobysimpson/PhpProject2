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
        <xsl:param name="s"/>
        <xsl:if test="number($x) = number($x)">
            <xsl:value-of select="php:function('sprintf',$s, number($x))"/>
        </xsl:if>
    </xsl:template>
    

    <xsl:template match="root">
 
        <table>
            <tr>
                <th>grp_id</th>
                <th>grp_name</th>
                
                <th>prc_id</th>
                <th>prc_name</th>
                
                
                <th>prd_id</th>
                <th>prd_name</th>
                
                <th>prm_id</th>
                <th>prm_code</th>
                <th>prm_cal</th>
                <th>prm_grw</th>
                
                <th>reg_a</th>
                <th>reg_b</th>

                <th>prm_eff</th>
                
                <th>prm_emi</th>
                <th>prm_lnd</th>
                <th>prm_cst</th>
                <th>prm_snl</th>
                <th>prd_los</th>
                <th>prm_src</th>
                
            </tr>
            
            
            <xsl:for-each select="tbl[1]/row">
                <!--                                <xsl:sort select="$grp/@grp_ord" data-type="number"/>
                <xsl:sort select="$prc/@prc_ord" data-type="number"/>
                <xsl:sort select="$prd/@prd_ord" data-type="number"/>-->
                <xsl:variable name="prm" select="current()"/>
                <xsl:variable name="prd" select="//tbl[3]/row[@prd_id = $prm/@prd_id]"/>
                <xsl:variable name="prc" select="//tbl[2]/row[@prc_id = $prm/@prc_id]"/>
                <xsl:variable name="grp" select="//tbl[1]/row[@grp_id = $prc/@grp_id]"/>

                
                <tr>
                    <td  style="text-align:center">
                        <xsl:value-of select="@grp_id"/>
                    </td>
                    <td  style="text-align:left">
                        <xsl:value-of select="@grp_name"/>
                    </td>
                    <td  style="text-align:center">
                        <xsl:value-of select="@prc_id"/>
                    </td>
                    <td  style="text-align:left">
                        <xsl:value-of select="@prc_name"/>
                    </td>
                    <td  style="text-align:center">
                        <xsl:value-of select="@prd_id"/>
                    </td>
                    <td>
                        <xsl:value-of select="@prd_name"/>
                    </td>
                    <td style="text-align:center">
                        <xsl:value-of select="@prm_id"/>  
                    </td>
                    <td style="text-align:left">
                        <xsl:value-of select="@grp_code"/>
                        <xsl:text>_</xsl:text>
                        <xsl:value-of select="@prc_code"/>
                        <xsl:text>_</xsl:text>
                        <xsl:value-of select="@prd_code"/>  
                    </td>
                    <td style="text-align:center">
                        <xsl:value-of select="@prm_cal"/>  
                    </td>
                    <td style="text-align:center">
                        <xsl:value-of select="@prm_grw"/>  
                    </td>
                    <td style="text-align:right">
                        <xsl:call-template name="fmt">
                            <xsl:with-param name="x" select = "@reg_a"/>
                            <xsl:with-param name="s" select="'%3.2f'"/>
                        </xsl:call-template>
                    </td>                                                        
                    <td style="text-align:right">
                        <xsl:call-template name="fmt">
                            <xsl:with-param name="x" select = "@reg_b"/>
                            <xsl:with-param name="s" select="'%3.2f'"/>
                        </xsl:call-template>
                    </td>

                    <td style="text-align:right">
                        <xsl:call-template name="fmt">
                            <xsl:with-param name="x" select = "@prm_eff"/>
                            <xsl:with-param name="s" select="'%f'"/>
                        </xsl:call-template>
                    </td>
                    <td style="text-align:right">
                        <xsl:call-template name="fmt">
                            <xsl:with-param name="x" select = "@prm_emi"/>
                            <xsl:with-param name="s" select="'%f'"/>
                        </xsl:call-template>
                    </td>
                    <td style="text-align:right">
                        <xsl:call-template name="fmt">
                            <xsl:with-param name="x" select = "@prm_lnd"/>
                            <xsl:with-param name="s" select="'%f'"/>
                        </xsl:call-template>
                    </td>
                    <td style="text-align:right">
                        <xsl:call-template name="fmt">
                            <xsl:with-param name="x" select = "@prm_cst"/>
                            <xsl:with-param name="s" select="'%f'"/>
                        </xsl:call-template>
                    </td>
                    <td style="text-align:right">
                        <xsl:call-template name="fmt">
                            <xsl:with-param name="x" select="@prm_snl"/>
                            <xsl:with-param name="s" select="'%f'"/>
                        </xsl:call-template>
                    </td>
                    <td style="text-align:right">
                        <xsl:call-template name="fmt">
                            <xsl:with-param name="x" select="@prd_los"/>
                            <xsl:with-param name="s" select="'%f'"/>
                        </xsl:call-template>
                    </td>
                    <td style="text-align:center">
                        <xsl:value-of select="@prm_src"/>  
                    </td>
                </tr>
            </xsl:for-each>

        </table>
    </xsl:template>
</xsl:stylesheet>