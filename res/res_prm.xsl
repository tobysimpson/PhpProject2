<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="utf-8" indent="yes"/>
    
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
            <!-- headers -->
            <tr>
                <th>prc_id</th>
                <th>prc_name</th>
                <xsl:for-each select="//tbl[4]/row">
                    <xsl:sort select="@prd_ord" data-type="number"/>
                    <th style="width:50px;">
                        <!--<xsl:value-of select="@prd_id"/>-->
                        <xsl:value-of select="@prd_code"/>
                    </th>
                </xsl:for-each>
            </tr>
            <!-- group -->
            <xsl:for-each select="tbl[2]/row">
                <xsl:sort select="@grp_ord" data-type="number"/>
                <xsl:variable name="grp" select="."/>
                <tr>
                    <td style="text-align:center;">
                        <xsl:value-of select="@grp_id"/>
                    </td>
                    <td colspan="15" style="font-weight:600;">
                        <xsl:value-of select="@grp_name"/>
                    </td>
<!--                    <td>
                        <xsl:value-of select="count(//tbl[3]/row[@grp_id=$grp/@grp_id])"/>
                    </td>-->
                </tr>
                <!-- process -->
                <xsl:for-each select="//tbl[3]/row[@grp_id=$grp/@grp_id]">
                    <xsl:variable name="prc" select="."/>
                    <tr>
                        <td  style="text-align:center">
                            <xsl:value-of select="@prc_id"/>
                        </td>
                        <td>
                            <xsl:value-of select="@prc_name"/>
                        </td>
                        <xsl:for-each select="//tbl[4]/row">
                            <xsl:sort select="@prd_ord" data-type="number"/>
                            <xsl:variable name="prd" select="."/>
                            <xsl:variable name="prm" select="//tbl[5]/row[@prc_id = $prc/@prc_id][@prd_id = $prd/@prd_id]"/>

                            <td>
                                <xsl:if test="$prm">
                                    <!-- <xsl:value-of select="$prm/@prm_id"/>-->
                                    <xsl:value-of select="$prm/@prm_code"/>
                                    <br/>
                                    <a href="prm.php?mth=edt&amp;res_id={$res_id}&amp;prm_id={$prm/@prm_id}&amp;xsl=1">
                                        <img src="prm.php?mth=prv&amp;res_id={$res_id}&amp;prm_id={$prm/@prm_id}&amp;xsl=1"/>
                                    </a>
                                    <br/>
                                    <a href="prm.php?mth=hst&amp;res_id={$res_id}&amp;prm_id={$prm/@prm_id}&amp;xsl=1">hst</a>,
                                    <a href="prm.php?mth=fwd&amp;res_id={$res_id}&amp;prm_id={$prm/@prm_id}&amp;xsl=1">fwd</a>,
                                    <a href="prm.php?mth=edt&amp;res_id={$res_id}&amp;prm_id={$prm/@prm_id}&amp;xsl=1">edt</a>,
                                    <a href="prm.php?mth=prv&amp;res_id={$res_id}&amp;prm_id={$prm/@prm_id}&amp;xsl=1">prv</a>
                                </xsl:if>
                            </td>
                        </xsl:for-each>
                    </tr>
                </xsl:for-each>
                
                
                
            </xsl:for-each>
        </table>

    </xsl:template>
</xsl:stylesheet>