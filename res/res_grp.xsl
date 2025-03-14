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
        <xsl:variable name="res" select="tbl[1]/row[1]"/>
       
        <table>
            <tr>
                <th>res_id</th>
                <th>res_name</th>
            </tr>
            <tr>
                <td style="text-align:center">
                    <xsl:value-of select="$res/@res_id"/>
                </td>
                <td>
                    <xsl:value-of select="$res/@res_name"/>
                </td>
            </tr>
        </table>
        
        <hr/>
        
        
        <table>
            <tr>
                <th>grp_id</th>
                <th>prc_id</th>
                <th></th>
                                    

                
            </tr>
            
            <!-- group -->
            <xsl:for-each select="tbl[2]/row">
                <xsl:sort select="@grp_ord" data-type="number"/>
                <xsl:variable name="grp" select="."/>
                <tr>
                    <td align="center">
                        <xsl:value-of select="@grp_id"/>
                    </td>
                    <td></td>
                    <td colspan="21" style="font-weight:600;">
                        <xsl:value-of select="@grp_name"/>
                    </td>
                </tr>
                
                <tr>
                    <td colspan="3"></td>
                 
                    <xsl:for-each select="//tbl[4]/row">
                        <xsl:sort select="@prd_ord" data-type="number"/>
                        <td width="60px" align="center">
                            <xsl:value-of select="@prd_id"/>
                            <br/>
                            <xsl:value-of select="@prd_code"/>
                        </td>
                    </xsl:for-each>
                    
                </tr>
                

                
                

                        
                <!-- process -->
                <xsl:for-each select="//tbl[3]/row">
                    <xsl:sort select="@prc_ord" data-type="number"/>
                    <xsl:variable name="prc" select="."/>
                    <xsl:variable name="prcs" select="//tbl[5]/row[@grp_id = $grp/@grp_id][@prc_id = $prc/@prc_id]"/>
                        
                    
                    <xsl:if test="$prcs">
                        <tr>
                            <td></td>
                            <td align="center">
                                <xsl:value-of select="./@prc_id"/>
                            </td>
                            <td>
                                <xsl:value-of select="./@prc_name"/>
                            </td>
                            
                            
                            <!-- product -->
                            <xsl:for-each select="//tbl[4]/row">
                                <xsl:sort select="@prd_ord" data-type="number"/>
                                <xsl:variable name="prd" select="."/>
                                <xsl:variable name="row" select="$prcs[@prd_id = $prd/@prd_id][@prc_id = $prc/@prc_id]"/>
                                <td align="center">
                                    

                                    <xsl:if test="$row">
                                        <xsl:value-of select="$row/@prm_id"/>
                                        <br/>
                                        <!--<xsl:choose>-->
<!--                                            <xsl:when test="$row/@prm_cal=0">
                                                <a href="prm.php?mth=edt&amp;res_id={$res/@res_id}&amp;prm_id={$row/@prm_id}&amp;xsl=1">
                                                    <img src="prm.php?mth=prv&amp;res_id={$res/@res_id}&amp;prm_id={$row/@prm_id}&amp;xsl=1"/>
                                                </a>
                                            </xsl:when>-->
                                            <!--<xsl:otherwise>-->
                                                <a href="prm.php?mth=fwd&amp;res_id={$res/@res_id}&amp;prm_id={$row/@prm_id}&amp;xsl=1">
                                                    <img src="prm.php?mth=prv&amp;res_id={$res/@res_id}&amp;prm_id={$row/@prm_id}&amp;xsl=1"/>
                                                </a>
<!--                                            </xsl:otherwise>
                                        </xsl:choose>-->
                                    </xsl:if>
                                    

                                    
                                </td>

                            </xsl:for-each>
                                
                        </tr>
  
                        
                    </xsl:if>
                           
                </xsl:for-each>
                
            </xsl:for-each>

        </table>
    </xsl:template>
</xsl:stylesheet>