<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:php="http://php.net/xsl">
    <xsl:output method="html" encoding="utf-8"/>
   
    <xsl:template match="root">
        <xsl:variable name="res_id" select="tbl[1]/@res_id"/>
        <xsl:variable name="prm_id" select="tbl[2]/@prm_id"/>
        <table>
            <tr> 
                <th>yr</th>
                <th>v1</th>
                <th>v2</th>
            </tr>
            <xsl:for-each select="tbl[3]/row">
                <tr>
                    <td>
                        <xsl:value-of select="@yr"/>
                    </td>
                    <td>
                        <input value="{format-number(@v1,'#,##0')}" onchange="fn_get('prm.php?mth=ups&amp;res_id={$res_id}&amp;prm_id={$prm_id}&amp;yr={@yr}&amp;v='+this.value, div1);" style="text-align:right;width:60px;"/>
                    </td>
                    <td style="text-align:right;">
                        <xsl:value-of select="format-number(@v2,'#,##0')"/>
                    </td>
                    <td>
                        <a href="#0" onclick="fn_get('prm.php?mth=clr&amp;res_id={@res_id}&amp;prm_id={@prm_id}&amp;p={@p}', div1);">clear</a>
                    </td>
                </tr>
            </xsl:for-each> 
        </table>
    </xsl:template>
</xsl:stylesheet>