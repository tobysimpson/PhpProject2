<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="utf-8" indent="yes" xalan:indent-amount="4"/>
    
    <xsl:include href="../nav.xsl"/>
    
    <xsl:template match="/">
        <xsl:call-template name="page"/> 
    </xsl:template>
    
    <xsl:template match="root">
        <xsl:variable name="res_id" select="tbl[1]/row/@res_id"/>
        
        <table>
            <tr>
                <th>res_id</th>
                <th>res_name</th>
            </tr>
            <tr>
                <td style="text-align:center">
                    <xsl:value-of select="tbl[1]/row/@res_id"/>
                </td>
                <td>
                    <xsl:value-of select="tbl[1]/row/@res_name"/>
                </td>
            </tr>
        </table>
        
        <hr/>
        
        
        <table>
            <tr>
                <td colspan="2">conversion</td>
            </tr>
            <tr>
                <td colspan="2"></td>
                <xsl:for-each select="//tbl[2]/row">
                    <xsl:sort select="@prd_ord" data-type="number"/>
                    <th>
                        <xsl:value-of select="@prd_code"/>
                        <xsl:value-of select="@prd_id"/>
                    </th>
                </xsl:for-each>
            </tr>
            <xsl:for-each select="//tbl[3]/row[@par_id=149]">
                <xsl:variable name="p1" select="@prm_id"/>
                <tr>
                    <!--                    <td style="text-align:center">
                        <xsl:value-of select="@prm_id"/>
                    </td>-->
                    <td colspan="2" style="white-space:nowrap;font-weight:600;">
                        <xsl:value-of select="@prm_name"/>
                    </td>
                </tr>
                <xsl:for-each select="//tbl[3]/row[@par_id=$p1]">
                    <xsl:variable name="prc" select="."/>
                    <tr>
                        <td style="text-align:center">
                            <xsl:value-of select="@prm_id"/>
                        </td>
                        <td>
                            <xsl:value-of select="@prm_name"/>
                        </td>
                    
                    
                    
                        <xsl:for-each select="//tbl[2]/row">
                            <xsl:sort select="@prd_ord" data-type="number"/>
                            <xsl:variable name="prd" select="."/>
                            <xsl:variable name="prm" select="//tbl[3]/row[@par_id = $prc/@prm_id][@prd_id = $prd/@prd_id]"/>

                            <td>
                                <xsl:if test="$prm">
                                    <xsl:value-of select="$prm/@prm_id"/>
                                    <xsl:text> - </xsl:text>
                                    <a href="prm.php?mth=fwd&amp;res_id={$res_id}&amp;prm_id={$prm/@prm_id}&amp;xsl=1">
                                        <xsl:value-of select="$prm/@prm_path_code"/>
                                    </a>
                                </xsl:if>
                            </td>
                        </xsl:for-each>
                    </tr>
                </xsl:for-each>
            </xsl:for-each>
 
               
            <tr>
                <td colspan="16">
                    <hr/>
                </td>
            </tr>

        
            <tr>
                <td colspan="2">consumption</td>
            </tr>
            <tr>
                <td colspan="2"></td>
                <xsl:for-each select="//tbl[2]/row">
                    <xsl:sort select="@prd_ord" data-type="number"/>
                    <th>
                        <xsl:value-of select="@prd_code"/>
                        <xsl:value-of select="@prd_id"/>
                    </th>
                </xsl:for-each>
            </tr>
            <xsl:for-each select="tbl[3]/row[@par_id=1]">
                <xsl:variable name="par_id" select="@prm_id"/>
                <tr>
                    <td style="text-align:center">
                        <xsl:value-of select="@prm_id"/>
                    </td>
                    <td>
                        <xsl:value-of select="@prm_name"/>
                    </td>
                    <!-- prd -->
                    <xsl:for-each select="//tbl[2]/row">
                        <xsl:sort select="@prd_ord" data-type="number"/>
                        <xsl:variable name="prd_id" select="@prd_id"/>
                        <xsl:variable name="prm" select="//tbl[3]/row[@par_id = $par_id][@prd_id = $prd_id]"/>
                        <td>
                            <xsl:if test="$prm">
                                <xsl:value-of select="$prm/@prm_id"/>
                                <xsl:text> - </xsl:text>
                                <a href="prm.php?mth=fwd&amp;res_id={$res_id}&amp;prm_id={$prm/@prm_id}&amp;xsl=1">
                                    <xsl:value-of select="$prm/@prm_path_code"/>
                                </a>
                            </xsl:if>
                        </td>
                    </xsl:for-each>
                </tr>
            </xsl:for-each>
        </table>

    </xsl:template>
</xsl:stylesheet>