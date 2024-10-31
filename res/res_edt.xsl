<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="utf-8"/>
    
    <xsl:include href="../nav.xsl"/>
    
    <xsl:template match="/">
        <xsl:call-template name="page"/> 
    </xsl:template>
    
    
    <xsl:template match="root/tbl/row">
        <form id="form1" action="res.php?mth=upd" method="post">
            <input type="hidden" name="xsl" value="1"   readonly="true"/>
            <table class="table2">
                <tr>
                    <th style="text-align:left;">res_id</th>
                    <td>
                        <input type="text" name="res_id" value="{@res_id}" readonly="true"/>
                    </td>
                </tr>
                <tr>
                    <th style="text-align:left;">res_name</th>
                    <td>
                        <input type="text" name="res_name" value="{@res_name}"/>
                    </td>
                </tr>
                
                <tr>
                    <th style="text-align:left;">res_txt</th>
                    <td>
                        <!--<input type="text" name="res_txt" value="{@res_txt}"/>-->
                        <textarea id="res_txt" name="res_txt" rows="20" cols="50" form="form1">
                            <xsl:value-of select="@res_txt"/>
                        </textarea>
                    </td>
                </tr>
                
                <tr>
                    <td>
                        <input type="submit"/>
                    </td>
                    <td/>
                </tr>
            </table>
        </form>
        
        
<!--        <hr/>

        <form action="../json.php?mth=txt" method="post">
            <input type="text" name="res_id" value="{@res_id}" readonly="true"/>
            <input type="text" name="res_txt" value="{@res_txt}"/>
            <input type="submit"/>
        </form>-->
        
        
    </xsl:template>
</xsl:stylesheet>