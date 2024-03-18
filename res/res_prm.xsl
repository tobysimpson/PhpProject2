<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="utf-8" indent="yes" xalan:indent-amount="4"/>
    
    <xsl:include href="../nav.xsl"/>
    
    <xsl:template match="/">
        <xsl:call-template name="page"/> 
    </xsl:template>
    
    <xsl:template match="root">
        
        <table>
            <tr>
                <th>res_id</th>
                <th>res_name</th>
            </tr>
            <tr>
                <td>
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
                    <td>
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
                            <xsl:if test="$prm">
                                <!--<xsl:value-of select="$par_id"/>,<xsl:value-of select="$prd_id"/>,<xsl:value-of select="$prm/@prm_id"/>,<xsl:value-of select="$prm/@prm_desc"/>-->
                                <a href="prm.php?mth=hst&amp;prm_id={$prm/@prm_id}&amp;xsl=1">
                                    <img src="prm.php?mth=hst&amp;prm_id={$prm/@prm_id}&amp;xsl=1" width="150px"/>
                                </a>
                            </xsl:if>
                        </td>
                    </xsl:for-each>
                </tr>
            </xsl:for-each>
        </table>
        <hr/>
        
        
        
        
        
        
        <table>
            <tr>
                <th>prm_id</th>
                <th>par_id</th>
                <th>prm_depth</th>
                <th>prm_path_code</th>
                <th>prm_desc</th>
                <th>reg_a</th>
                <th>reg_b</th>
                <th>prm_def</th>
            </tr>
            <xsl:for-each select="tbl[2]/row">
                <tr>
                    <td style="text-align:center">
                        <xsl:value-of select="@prm_id"/>
                    </td>
                    <td style="text-align:center">
                        <xsl:value-of select="@par_id"/>
                    </td>
                    <td style="text-align:center">
                        <xsl:value-of select="@prm_depth"/>
                    </td>
                    <td>
                        <xsl:value-of select="@prm_path_code"/>
                    </td>
                    <td>
                        <xsl:value-of select="@prm_desc"/>
                    </td>
                    <td style="text-align:right">
                        <xsl:value-of select="@reg_a"/>
                    </td>
                    <td style="text-align:right">
                        <xsl:value-of select="@reg_b"/>
                    </td>
                    <td style="text-align:right">
                        <xsl:value-of select="@prm_def"/>
                    </td>
                    <td>
                        <xsl:if test="@reg_a!=''">
                            <a href="prm.php?mth=hst&amp;prm_id={@prm_id}&amp;xsl=1">prm_hst</a>
                        </xsl:if>
                    </td>
                </tr>
            </xsl:for-each> 
        </table>
    </xsl:template>
</xsl:stylesheet>