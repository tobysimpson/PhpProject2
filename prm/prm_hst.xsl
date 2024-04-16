<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>

    <xsl:include href="../plot.xsl"/>
        
    <xsl:variable name="h">600</xsl:variable>
    <xsl:variable name="w">1000</xsl:variable>
    
    <xsl:variable name="ph" select="0.8 * $h"/>
    <xsl:variable name="pw" select="0.9 * $w"/>
    
    <xsl:variable name="ho" select="0.1 * $h"/>
    <xsl:variable name="wo" select="0.05 * $w"/>
    
    <xsl:variable name="tt" select="root/tbl[2]/row/@yr" />
    <!--<xsl:variable name="vv" select="root/tbl[2]/row/@tj" />-->
    <xsl:variable name="vv" select="root/tbl[2]/row/@*[name()='tj' or name()='reg']" />
    

    <xsl:variable name="tmin">
        <xsl:call-template name="min">
            <xsl:with-param name="nodes" select="$tt" />
        </xsl:call-template>
    </xsl:variable>
                
    <xsl:variable name="tmax">
        <xsl:call-template name="max">
            <xsl:with-param name="nodes" select="$tt" />
        </xsl:call-template>
    </xsl:variable>
                 
    <xsl:variable name="vmin">
        <xsl:call-template name="min0">
            <xsl:with-param name="nodes" select="$vv" />
        </xsl:call-template>
    </xsl:variable>
                
    <xsl:variable name="vmax">
        <xsl:call-template name="max0">
            <xsl:with-param name="nodes" select="$vv" />
        </xsl:call-template>
    </xsl:variable>
                
                
    <xsl:variable name="ttick">
        <xsl:call-template name="tick">
            <xsl:with-param name="rng" select="$tmax - $tmin" />
        </xsl:call-template>
    </xsl:variable> 
                
    <xsl:variable name="vtick">
        <xsl:call-template name="tick">
            <xsl:with-param name="rng" select="$vmax - $vmin" />
        </xsl:call-template>
    </xsl:variable> 
                
    <!--<xsl:variable name="ttick" select="1.00"/>-->
    <!--<xsl:variable name="vtick" select="0.25"/>-->
                
    <xsl:variable name="trng" select="$tmax - $tmin"/>
    <xsl:variable name="vinf" select="(floor($vmin div $vtick)) * $vtick"/>
    <xsl:variable name="vsup" select="(ceiling($vmax div $vtick)) * $vtick"/>
    <xsl:variable name="vrng" select="$vsup - $vinf"/>

                
    <xsl:variable name="tdash" select="$pw * $ttick div $trng * 0.125"/>
    <xsl:variable name="vdash" select="$ph * $vtick div $vrng * 0.125"/>
    
    
   
    <xsl:template match="root">
        <svg width="{$w}" height="{$h}" xmlns="http://www.w3.org/2000/svg" >
            <style>* { font-size: 10pt; font-family: sans-serif; font-weight: 300; }</style> 
            

            <g id="title" transform="translate(40,20)">
                <text x="0" y="0" alignment-baseline="middle">
                    <xsl:value-of select="tbl[1]/row/@prm_id"/>
                    <xsl:text> - </xsl:text>
                    <xsl:value-of select="tbl[1]/row/@prm_desc"/>
                </text>
            </g>
                
                
                
            <g id="plot" transform="translate({$wo},{$ho})"> 
                
                <xsl:variable name="pzro" select="format-number($ph * (1 + $vinf div $vrng),'0.0')"/>
                    <g id="poly">
                        <xsl:variable name="points">
                            <xsl:for-each select="tbl[2]/row">
                                <xsl:sort select="@yr" data-type="number" order="ascending"/>
                                <xsl:variable name="x" select="format-number($pw * (@yr - $tmin) div $trng,'0.00')"/>
                                <xsl:variable name="y" select="format-number($ph * (1 - (@tj - $vinf) div $vrng),'0.0')"/>
                                <xsl:choose>
                                    <xsl:when test="position()=1">
                                        <xsl:text>0,</xsl:text>
                                        <xsl:value-of select="$pzro"/>
                                        <xsl:text> </xsl:text>
                                        <xsl:value-of select="$x"/>
                                        <xsl:text>,</xsl:text>
                                        <xsl:value-of select="$y"/>
                                        <xsl:text> </xsl:text>
                                    </xsl:when>
                                    <xsl:when test="position()=last()">
                                        <xsl:value-of select="$x"/>
                                        <xsl:text>,</xsl:text>
                                        <xsl:value-of select="$y"/>
                                        <xsl:text> </xsl:text>
                                        <xsl:value-of select="$pw"/>
                                        <xsl:text>,</xsl:text>
                                        <xsl:value-of select="$pzro"/>
                                        <xsl:text> </xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="$x"/>
                                        <xsl:text>,</xsl:text>
                                        <xsl:value-of select="$y"/>
                                        <xsl:text> </xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </xsl:variable>
                        <g id="polyline">
                            <polyline points="{$points}" fill="#EEEEFF" stroke="none" />
                        </g>
                    </g>
                
                
                
                <g id="vgrid">
                    <xsl:for-each select="$tt">
                        <xsl:variable name="i" select="position()"/>
                        <xsl:if test="$tt[$i] mod $ttick = 0">
                            <xsl:variable name="x" select="format-number($pw * ($tt[$i] - $tmin) div $trng,'0.00')"/>
                            <line x1="{$x}" y1="0" x2="{$x}" y2="{$ph}" stroke="lightgray" stroke-dasharray="{$vdash},{$vdash}" stroke-dashoffset="{$vdash * 0.5}"/>
                           
                            <g id="label" transform="translate({$x}, {$ph + 10})">
                                <text text-anchor="end" transform="rotate(-90)" alignment-baseline="middle">
                                    <xsl:value-of select="format-number($tt[$i],'0')"/>
                                </text>
                            </g>
                            
                        </xsl:if>
                    </xsl:for-each>  
                </g> 
              
              
                <g id="hgrid">       
                    <xsl:call-template name="hgrid">
                        <xsl:with-param name="vpos" select="$vinf" />
                    </xsl:call-template>
                </g>
                
                
                <g id="lines">
                    <g id="line">
                        <xsl:variable name="line1">
                            <xsl:for-each select="tbl[2]/row">
                                <xsl:variable name="i" select="position()"/>
                                <xsl:variable name="x" select="format-number($pw * (@yr - $tmin) div $trng,'0.00')"/>
                                <!--<xsl:variable name="y" select="@*[$j + 3]"/>-->
                                <xsl:variable name="y" select="format-number($ph * (1 - (@tj - $vinf) div $vrng),'0.00')"/>
                                <xsl:choose>
                                    <xsl:when test="position()=1">
                                        <xsl:text>M </xsl:text>
                                        <xsl:value-of select="$x"/>
                                        <xsl:text>,</xsl:text>
                                        <xsl:value-of select="$y"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text> L </xsl:text>
                                        <xsl:value-of select="$x"/>
                                        <xsl:text>,</xsl:text>
                                        <xsl:value-of select="$y"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </xsl:variable>
                        <path fill="none"  d="{$line1}" stroke-width="1" stroke="#6666FF" />
                    </g>
                    
                    <g id="line">
                        <xsl:variable name="line2">
                            <xsl:for-each select="tbl[2]/row[@yr &gt;= 2014]">
                                <xsl:variable name="i" select="position()"/>
                                <xsl:variable name="x" select="format-number($pw * (@yr - $tmin) div $trng,'0.00')"/>
                                <!--<xsl:variable name="y" select="@*[$j + 3]"/>-->
                                <xsl:variable name="y" select="format-number($ph * (1 - (@reg - $vinf) div $vrng),'0.00')"/>
                                <xsl:choose>
                                    <xsl:when test="position()=1">
                                        <xsl:text>M </xsl:text>
                                        <xsl:value-of select="$x"/>
                                        <xsl:text>,</xsl:text>
                                        <xsl:value-of select="$y"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text> L </xsl:text>
                                        <xsl:value-of select="$x"/>
                                        <xsl:text>,</xsl:text>
                                        <xsl:value-of select="$y"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </xsl:variable>
                        <path fill="none"  d="{$line2}" stroke-width="1" stroke="#FF6666" />
                    </g>
                </g>
                
                
                <g id="dots">
                    <g id="series">
                        <xsl:for-each select="tbl[2]/row">
                            <xsl:variable name="i" select="position()"/>
                            <xsl:variable name="x" select="format-number($pw * (@yr - $tmin) div $trng,'0.00')"/>
                            <xsl:variable name="y" select="format-number($ph * (1 - (@tj - $vinf) div $vrng),'0.00')"/>
                            <circle cx="{$x}" cy="{$y}" r="2" stroke="#6666FF" fill="#6666FF"/>
                        </xsl:for-each>
                    </g>
                    
                    <g id="reg">
                        <xsl:for-each select="tbl[2]/row[@yr &gt;= 2014]">
                            <xsl:variable name="i" select="position()"/>
                            <xsl:variable name="x" select="format-number($pw * (@yr - $tmin) div $trng,'0.00')"/>
                            <xsl:variable name="y" select="format-number($ph * (1 - (@reg - $vinf) div $vrng),'0.00')"/>
                            <circle cx="{$x}" cy="{$y}" r="2" stroke="#FF6666" fill="#FFFFFF"/>
                        </xsl:for-each>
                    </g>
                </g>
                

            </g>
        </svg>
    </xsl:template>
    

    <xsl:template name="hgrid">
        <xsl:param name="vpos"/>
        <xsl:variable name="y" select="format-number($ph * (1 - ($vpos - $vinf) div $vrng),'0.00')"/>
        <text xmlns="http://www.w3.org/2000/svg" x="{$pw + 50}" y="{$y}" alignment-baseline="middle" text-anchor="end">
            <xsl:value-of select="format-number($vpos,'#,##0')"/>
        </text>
        <line xmlns="http://www.w3.org/2000/svg" x1="0" y1="{$y}" x2="{$pw}" y2="{$y}" stroke="lightgrey" stroke-dasharray="{$tdash},{$tdash}" stroke-dashoffset="{$tdash * 0.5}" />
        <xsl:if test="format-number($vpos,'0.000') &lt; format-number($vsup,'0.000')">
            <xsl:call-template name="hgrid">
                <xsl:with-param name="vpos" select="$vpos + $vtick" />
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    
</xsl:stylesheet>


