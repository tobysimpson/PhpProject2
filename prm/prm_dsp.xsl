<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="utf-8"/>
    
    <xsl:include href="../nav.xsl"/>
    
    <xsl:template match="/">
        <xsl:call-template name="page"/> 
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
                <th>prm_def</th>
                <th>prm_eff</th>
                
                
            </tr>
            <!-- group -->
            <xsl:for-each select="tbl[1]/row">
                <xsl:sort select="@grp_ord" data-type="number"/>
                <xsl:variable name="grp" select="."/>
                <tr>
                    <td style="text-align:center;">
                        <xsl:value-of select="@grp_id"/>
                    </td>
                    <td>
                        <xsl:value-of select="@grp_name"/>
                    </td>
                    <td/>
                    <td/>
                    <td/>
                    <td/>
                    <td/>
                    <td/>
                    <td/>
                    <td/>
                    <td/>
                    <td/>
                    <td/>
                </tr>
 
                <!-- process -->
                <xsl:for-each select="//tbl[2]/row[@grp_id=$grp/@grp_id]">
                    <xsl:sort select="@prc_ord" data-type="number"/>
                    <xsl:variable name="prc" select="."/>
                    <tr>
                        <td/>
                        <td/>
                        <td  style="text-align:center">
                            <xsl:value-of select="@prc_id"/>
                        </td>
                        <td>
                            <xsl:value-of select="@prc_name"/>
                        </td>
                        <td/>
                        <td/>
                        <td/>
                        <td/>
                        <td/>
                        <td/>
                        <td/>
                        <td/>
                        <td/>
                    </tr>

                    <!-- parameter -->   
                    <xsl:for-each select="//tbl[4]/row[@prc_id = $prc/@prc_id]">
                        <xsl:sort select="//tbl[3]/row[@prd_id = current()/@prd_id]/@prd_ord" data-type="number"/>
                        <xsl:variable name="prm" select="."/>
                        <xsl:variable name="prd" select="//tbl[3]/row[@prd_id = $prm/@prd_id]"/>
                        <tr>
                            <td/>
                            <td/>
                            <td/>
                            <td/>

                            <td  style="text-align:center">
                                <xsl:value-of select="$prd/@prd_id"/>
                            </td>
                            <td>
                                <xsl:value-of select="$prd/@prd_name"/>
                            </td>
                            <td style="text-align:center">
                                <xsl:value-of select="$prm/@prm_id"/>  
                            </td>
                            <td style="text-align:center">
                                <xsl:value-of select="$grp/@grp_code"/>
                                <xsl:text>_</xsl:text>
                                <xsl:value-of select="$prc/@prc_code"/>
                                <xsl:text>_</xsl:text>
                                <xsl:value-of select="$prd/@prd_code"/>  
                            </td>
                            <td style="text-align:center">
                                <xsl:value-of select="$prm/@prm_cal"/>  
                            </td>
                            <td style="text-align:center">
                                <xsl:value-of select="$prm/@prm_grw"/>  
                            </td>
                            <td style="text-align:right">
                                <xsl:value-of select="$prm/@reg_a"/>  
                            </td>                                                        
                            <td style="text-align:right">
                                <xsl:value-of select="$prm/@reg_b"/>  
                            </td>
                            <td style="text-align:right">
                                <xsl:value-of select="$prm/@prm_def"/>  
                            </td>
                            <td style="text-align:right">
                                <xsl:value-of select="$prm/@prm_eff"/>  
                            </td>
                        </tr>
                    </xsl:for-each>
                
                </xsl:for-each>

            </xsl:for-each>
        </table>

    </xsl:template>
</xsl:stylesheet>