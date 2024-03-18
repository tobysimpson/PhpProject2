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
                <th>prm_id</th>
                <th>prm_name</th>
                <xsl:for-each select="//tbl[2]/row">
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
                        <xsl:variable name="prd_id" select="@prd_id"/>
                        <xsl:variable name="prm" select="//tbl[3]/row[@par_id = $par_id][@prd_id = $prd_id]"/>
                        <td>
                            <!--<xsl:value-of select="$par_id"/>,<xsl:value-of select="$prd_id"/>,<xsl:value-of select="$prm/@prm_id"/>,<xsl:value-of select="$prm/@prm_desc"/>-->
                            <xsl:if test="$prm">
                                <a href="prm.php?mth=fwd&amp;res_id={$res_id}&amp;prm_id={$prm/@prm_id}&amp;xsl=1">
                                    <xsl:value-of select="$prm/@prm_path_code"/>
                                </a>
                                                             
                                <!--                                <a href="#0" onclick="fn_get('prm.php?mth=fwd&amp;res_id={$res_id}&amp;prm_id={$prm/@prm_id}&amp;xsl=1',div1)">
                                    <xsl:value-of select="$prm/@prm_path_code"/>
                                </a>-->
                            
                                <br/>
                                <!--<a href="prm.php?mth=hst&amp;prm_id={$prm/@prm_id}&amp;xsl=1">
                                    <img src="prm.php?mth=hst&amp;prm_id={$prm/@prm_id}&amp;xsl=1" width="180px"/>
                                </a>-->
   
                            
                                <!--<a href="prm.php?mth=fwd&amp;res_id={$res_id}&amp;prm_id={$prm/@prm_id}&amp;xsl=1">-->
                                <a href="#0" onclick="fn_get('prm.php?mth=fwd&amp;res_id={$res_id}&amp;prm_id={$prm/@prm_id}&amp;xsl=1',div1)">
                                    <img src="prm.php?mth=fwd&amp;res_id={$res_id}&amp;prm_id={$prm/@prm_id}&amp;xsl=1" width="160px"/>
                                </a>
                            </xsl:if>
                        </td>
                    </xsl:for-each>
                </tr>
            </xsl:for-each>
        </table>
        <hr/>
        <div id="div1"></div>
   
        
       
    </xsl:template>
</xsl:stylesheet>