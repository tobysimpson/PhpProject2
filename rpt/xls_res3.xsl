<?xml version="1.0" encoding="UTF-8"?>
<!--<?mso-application progid="Excel.Sheet"?>-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
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
                            <Data ss:Type="String">yr</Data>
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
                        
                        <Cell>
                            <Data ss:Type="String">avl_sol</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">avl_wnd</Data>
                        </Cell>
                        
                        <Cell>
                            <Data ss:Type="String">cns_hsh</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">cns_ind</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">cns_srv</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">cns_tra</Data>
                        </Cell>
                        <Cell>
                            <Data ss:Type="String">cns_agr</Data>
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
                                    <xsl:value-of select="@yr"/>
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
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@avl_sol"/>
                                </Data>
                            </Cell>
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@avl_wnd"/>
                                </Data>
                            </Cell>
                            
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@cns_hsh"/>
                                </Data>
                            </Cell>                            
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@cns_ind"/>
                                </Data>
                            </Cell>                            
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@cns_srv"/>
                                </Data>
                            </Cell>                            
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@cns_tra"/>
                                </Data>
                            </Cell>                            
                            <Cell>
                                <Data ss:Type="Number">
                                    <xsl:value-of select="@cns_agr"/>
                                </Data>
                            </Cell>                            
                        </Row>
                    </xsl:for-each> 
                </Table>
            </Worksheet>
        </Workbook>
    </xsl:template>
</xsl:stylesheet>