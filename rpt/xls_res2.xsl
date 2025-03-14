<?xml version="1.0" encoding="UTF-8"?>
<!--<?mso-application progid="Excel.Sheet"?>-->
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:php="http://php.net/xsl">
    <!--<xsl:output method="html" encoding="utf-8"/>-->
    
<!--    <xsl:include href="../nav.xsl"/>
    
    <xsl:template match="/">
        <xsl:call-template name="page"/> 
    </xsl:template>-->
    
    <xsl:template name="fmt">
        <xsl:param name="x"/>
        <xsl:if test="number($x) = number($x)">
            <xsl:value-of select="php:function('sprintf','%6.4e', number($x))"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="root">
        
        
        <Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
                  xmlns:o="urn:schemas-microsoft-com:office:office"
                  xmlns:x="urn:schemas-microsoft-com:office:excel"
                  xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
                  xmlns:html="http://www.w3.org/TR/REC-html40">
            <Worksheet ss:Name="Table1">
                <Table>
                    <Column ss:Index="2" ss:AutoFitWidth="0" ss:Width="110"/>
                    <Column ss:Index="3" ss:AutoFitWidth="0" ss:Width="110"/>
                    <Column ss:Index="4" ss:AutoFitWidth="0" ss:Width="110"/>
                    <Column ss:Index="6" ss:AutoFitWidth="0" ss:Width="110"/>
                    <Row>
                        <Cell>
                            <Data ss:Type="String">res_id</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">res_name</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">res_date</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">res_upd</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">res_yr</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">res_tok</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">res_frm</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">res_trt</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">res_lng</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">met_nuc</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">met_fos</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">met_ele</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">met_emi</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">met_lnd</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">met_cst</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">met_smr</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">cap_gas</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">cap_nuc</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">cap_riv</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">cap_res</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">cap_wst</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">cap_woo</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">cap_bgs</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">cap_sol</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">cap_wnd</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">cap_ccs</Data>
                        </Cell>
                    </Row>

		
        
        
      
   
                    <xsl:for-each select="tbl[1]/row">
                        <Row>
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@res_id"/>
                                </Data>
                            </Cell>
                            <Cell>
                                <Data ss:Type="String">
                                    <xsl:value-of select="@res_name"/>
                                </Data>
                            </Cell>
                            <Cell>
                                <Data ss:Type="String">
                                    <xsl:value-of select="@res_date"/>
                                </Data>
                            </Cell>
                            <Cell>
                                <Data ss:Type="String">
                                    <xsl:value-of select="@res_upd"/>
                                </Data>
                            </Cell>
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@res_yr"/>
                                </Data>
                            </Cell>
                            <Cell>
                                <Data ss:Type="String">
                                    <xsl:value-of select="@res_tok"/>
                                </Data>
                            </Cell>
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@res_frm"/>
                                </Data>
                            </Cell>
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@res_trt"/>
                                </Data>
                            </Cell>
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@res_lng"/>
                                </Data>
                            </Cell>
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@met_nuc"/>
                                </Data>
                            </Cell>
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@met_fos"/>
                                </Data>
                            </Cell>
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@met_ele"/>
                                </Data>
                            </Cell>
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@met_emi"/>
                                </Data>
                            </Cell>
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@met_lnd"/>
                                </Data>
                            </Cell>
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@met_cst"/>
                                </Data>
                            </Cell>
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@met_smr"/>
                                </Data>
                            </Cell>
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@cap_gas"/>
                                </Data>
                            </Cell>
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@cap_nuc"/>
                                </Data>
                            </Cell>
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@cap_riv"/>
                                </Data>
                            </Cell>
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@cap_res"/>
                                </Data>
                            </Cell>
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@cap_wst"/>
                                </Data>
                            </Cell>
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@cap_woo"/>
                                </Data>
                            </Cell>
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@cap_bgs"/>
                                </Data>
                            </Cell>
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@cap_sol"/>
                                </Data>
                            </Cell>
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@cap_wnd"/>
                                </Data>
                            </Cell>
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@cap_ccs"/>
                                </Data>
                            </Cell>
                        </Row>
                    </xsl:for-each> 
                </Table>
            </Worksheet>
        </Workbook>
    </xsl:template>
</xsl:stylesheet>