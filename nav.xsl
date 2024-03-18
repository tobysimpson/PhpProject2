<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="utf-8" indent="yes"/>

    <xsl:template name="page">
        <html>
            <head>
                <title></title>
                <link rel="stylesheet" href="https://sure.euler.usi.ch/styles.css"/>
            </head>
            <body>
                <!--layout--> 
                <table width="100%">
                    <tr>
                        <!--logo--> 
                        <td>
                            <a href="https://sure.euler.usi.ch">
                                <img style="width:100px; height:auto;" src="https://sure.euler.usi.ch/logo_usi1.svg"/>
                            </a>
                        </td>
                        <!--head--> 
                        <td/>
                    </tr>
                    <tr>
                        <!-- navigation -->
                        <td width="120px" style="vertical-align:top">
                            <xsl:call-template name="menu"/>
                        </td>
                        <!-- body -->
                        <td style="vertical-align:top">
                            <xsl:apply-templates/>
                        </td>
                    </tr>
                </table>
            </body>
        </html>
    </xsl:template>
    

    <xsl:template name="menu">
        <table width="100%">
            <tr>
                <th style="text-align:left">res</th>
            </tr>
            <tr>
                <td>
                    <a href="res.php?mth=lst&amp;xsl=1">res_lst</a>
                </td>
            </tr>
            <tr>
                <th style="text-align:left">prm</th>
            </tr>
            <tr>
                <td>
                    <a href="prm.php?mth=rec&amp;xsl=1">prm_rec</a>
                </td>
            </tr>
            <tr>
                <th style="text-align:left">item</th>
            </tr>
            <tr>
                <td>
                    <a href="item.php?mth=lst&amp;xsl=1">item_lst</a>
                </td>
            </tr>
        </table>
    </xsl:template>
 
</xsl:stylesheet>