<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:php="http://php.net/xsl">
    
    <xsl:output method="html" encoding="utf-8"/>

    <xsl:include href="../nav.xsl"/>
    
    
    <xsl:template name="fmt">
        <xsl:param name="x"/>
        <xsl:if test="number($x) = number($x)">
            <xsl:value-of select="php:function('sprintf','%e', number($x))"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:call-template name="page"/> 
    </xsl:template>
    
  
    
    <xsl:template match="root">
        <xsl:variable name="res" select="tbl[1]/row[1]"/>
       
      
     
        <table>

            <tr>
                <th>grp_id</th>
                <th>grp_name</th>
                <th>prc_id</th>
                <th>prc_name</th>        
                <th>prm_id</th>
                <th>prm_cal</th>
                <th>prd_id</th>    
                <th>prd_name</th>   
                <th>prd_id2</th>   
                <th>prd_name2</th>     
                <th>reg_a</th>     
                <th>reg_b</th>   
            </tr>
            <!-- group -->
            <xsl:for-each select="tbl[1]/row">
                <xsl:sort select="@grp_ord" data-type="number"/>
                <xsl:variable name="grp" select="."/>

                <tr>
                    <td align="center">
                        <xsl:value-of select="@grp_id"/>
                    </td>
                    <td >
                        <xsl:value-of select="@grp_name"/>
                    </td>

                    <td align="center">
                        <xsl:value-of select="@prc_id"/>
                    </td>
                    <td >
                        <xsl:value-of select="@prc_name"/>
                    </td>
                        
      
   
                    <td align="center">
                        <xsl:value-of select="@prm_id"/>
                    </td>
                    <td align="center">
                        <xsl:value-of select="@prm_cal"/>
                    </td>
                    <td align="center">
                        <xsl:value-of select="@prd_id"/>
                    </td>
                    <td>
                        <xsl:value-of select="@prd_name"/>
                    </td>
                    <td align="center">
                        <xsl:value-of select="@prd_id2"/>
                    </td>
                    <td>
                        <xsl:value-of select="@prd_name2"/>
                    </td>
                    <td align="right">
                        <xsl:call-template name="fmt">
                            <xsl:with-param name="x" select="@reg_a"/>
                        </xsl:call-template>
                    </td>
                    <td align="right">
                        <xsl:call-template name="fmt">
                            <xsl:with-param name="x" select="@reg_b"/>
                        </xsl:call-template>
                    </td>
                </tr>
           

          
                
            </xsl:for-each>

        </table>
    </xsl:template>
</xsl:stylesheet>