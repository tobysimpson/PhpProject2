<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="utf-8"/>


    <xsl:template match="root">
        <html>
            <head>
                <title></title>
                <link rel="stylesheet" href="https://toby.euler.usi.ch/styles.css"/>
            </head>
            <body>
                <table class="table1">
                <tr>
                    <th>id</th>
                    <th>date</th>
                    <th>size</th>
                    <th>type</th>
                    <th>name</th>
                    <th>note</th>
                </tr>
                <xsl:for-each select="row">
                    <tr>
                        <td>
                            <xsl:value-of select="@id"/>
                        </td>
                        <td>
                            <xsl:value-of select="@date"/>
                        </td>
                        <td>
                            <xsl:value-of select="@size"/>
                        </td>
                        <td>
                            <xsl:value-of select="@type"/>
                        </td>
                        <td style="text-align:left;">
                            <!--<a href="item.php?mth=download&amp;id={@id}&amp;name={@name}"><xsl:value-of select="@name"/></a>-->
                            <xsl:value-of select="@name"/>
                        </td>
     
                        <td style="text-align:left;">
                            <xsl:value-of select="@note"/>
                        </td>
                        <td style="text-align:left;">
                            <a href="uploads/{@id}">download</a>
                        </td>
                    </tr>
                </xsl:for-each> 
            </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>