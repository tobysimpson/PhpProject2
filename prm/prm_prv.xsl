<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>

    <xsl:include href="../plot.xsl"/>
    <xsl:include href="../nav.xsl"/>
    

    
    <!--    <xsl:template match="/">
        <xsl:call-template name="page"/> 
    </xsl:template>-->
   
    <xsl:variable name="ph">40</xsl:variable>
    <xsl:variable name="pw">80</xsl:variable>
        
    <xsl:variable name="h" select="$ph+4"/>
    <xsl:variable name="w" select="$pw+4"/>
    
    <xsl:variable name="ho" select="2"/>
    <xsl:variable name="wo" select="2"/>
    

    
    <xsl:variable name="tt" select="root/tbl[*]/row/@yr" />
    <xsl:variable name="tt2" select="root/tbl[4]/row/@yr" />
    <!--<xsl:variable name="vv" select="root/tbl[2]/row/@tj" />-->
    <xsl:variable name="vv" select="root/tbl[*]/row/@*[name()='tj' or name()='reg']" />
    
    <!--<xsl:variable name="tt" select="$tt1 | $tt2" />-->

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
        <svg width="{$w}" height="{$h}" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
            
            <!--            <link xmlns="http://www.w3.org/1999/xhtml" rel="stylesheet" href="../styles.css" type="text/css" />-->

 
            <g id="plot" transform="translate({$wo},{$ho})"> 
                
                <xsl:variable name="pzro" select="format-number($ph * (1 + $vinf div $vrng),'0.0')"/>
                <g id="poly">
                    <xsl:variable name="points">
                        <xsl:for-each select="tbl[3]/row">
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
                                    <xsl:value-of select="$x"/>
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
                            <xsl:variable name="x" select="format-number($pw * ($tt[$i] - $tmin) div $trng,'0.000')"/>
                            <line x1="{$x}" y1="0" x2="{$x}" y2="{$ph}" stroke="lightgray" stroke-dasharray="5,5" stroke-dashoffset="{$vdash * 0.5}"/>
                           
                            <!--<line x1="{$x}" y1="0" x2="{$x}" y2="{$ph}" stroke="lightgray"/>-->
                            
                        </xsl:if>
                    </xsl:for-each>  
                </g> 
              
              
                <!--                <g id="hgrid">       
                    <xsl:call-template name="hgrid">
                        <xsl:with-param name="vpos" select="$vinf" />
                    </xsl:call-template>
                </g>-->
                
                
                <g id="hist">
                    <g id="line1">
                        <xsl:variable name="line1">
                            <xsl:for-each select="tbl[3]/row">
                                <xsl:variable name="i" select="position()"/>
                                <xsl:variable name="x" select="format-number($pw * (@yr - $tmin) div $trng,'0.000')"/>
                                <xsl:variable name="y" select="format-number($ph * (1 - (@tj - $vinf) div $vrng),'0.000')"/>
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
                    
                    <g id="reg">
                        <xsl:variable name="line2">
                            <xsl:for-each select="tbl[3]/row[@yr &gt;= 2011]">
                                <xsl:variable name="i" select="position()"/>
                                <xsl:variable name="x" select="format-number($pw * (@yr - $tmin) div $trng,'0.000')"/>
                                <xsl:variable name="y" select="format-number($ph * (1 - (@reg - $vinf) div $vrng),'0.000')"/>
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
                    
                    
                    <g id="line3">
                        <xsl:variable name="line3">
                            <xsl:for-each select="tbl[4]/row">
                                <xsl:variable name="i" select="position()"/>
                                <xsl:variable name="x" select="format-number($pw * (@yr - $tmin) div $trng,'0.000')"/>
                                <xsl:variable name="y" select="format-number($ph * (1 - (@tj - $vinf) div $vrng),'0.000')"/>
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
                        <path fill="none"  d="{$line3}" stroke-width="1" stroke="#006600" />
                    </g>
                    
                    
                    
                </g>
                
               
                <!--                <g id="dots">
                    <g id="series">
                        <xsl:for-each select="tbl[3]/row">
                            <xsl:variable name="i" select="position()"/>
                            <xsl:variable name="x" select="format-number($pw * (@yr - $tmin) div $trng,'0.00')"/>
                            <xsl:variable name="y" select="format-number($ph * (1 - (@tj - $vinf) div $vrng),'0.00')"/>
                            <circle cx="{$x}" cy="{$y}" r="2" stroke="#6666FF" fill="#6666FF"/>
                        </xsl:for-each>
                    </g>
                    
                    <g id="reg">
                        <xsl:for-each select="tbl[3]/row[@yr &gt; 2009]">
                            <xsl:variable name="i" select="position()"/>
                            <xsl:variable name="x" select="format-number($pw * (@yr - $tmin) div $trng,'0.00')"/>
                            <xsl:variable name="y" select="format-number($ph * (1 - (@v - $vinf) div $vrng),'0.00')"/>
                            <circle cx="{$x}" cy="{$y}" r="2" stroke="#FF6666" fill="#FFFFFF"/>
                        </xsl:for-each>
                    </g>
                    
                    
                    <g id="forward">
                        <xsl:for-each select="tbl[4]/row">
                            <xsl:variable name="i" select="position()"/>
                            <xsl:variable name="x" select="format-number($pw * (@yr - $tmin) div $trng,'0.00')"/>
                            <xsl:variable name="y" select="format-number($ph * (1 - (@v - $vinf) div $vrng),'0.00')"/>
                            <circle cx="{$x}" cy="{$y}" r="2" stroke="#006600" fill="#FFFFFF"/> 
                        </xsl:for-each>
                    </g>
                    
                </g>-->
            </g>
            
            <g id="txt" transform="translate(0,0)">
                <text x="{$w * 0.5}" y="{$h * 0.2}" alignment-baseline="middle" text-anchor="middle" font-family="sans-serif" font-weight="200" font-size="9pt" fill="#6666FF">
                    <xsl:value-of select="format-number(tbl[3]/row[last()]/@tj,'#,##0.00')"/>
                </text>
                <text x="{$w * 0.5}" y="{$h * 0.5}" alignment-baseline="middle" text-anchor="middle" font-family="sans-serif" font-weight="200" font-size="9pt" fill="#FF6666">
                    <xsl:value-of select="format-number(tbl[2]/row[1]/@reg_b,'#,##0.00')"/>
                </text>
                <text x="{$w * 0.5}" y="{$h * 0.8}" alignment-baseline="middle" text-anchor="middle" font-family="sans-serif" font-weight="200" font-size="9pt" fill="#006600">
                    <xsl:value-of select="format-number(tbl[4]/row[1]/@tj,'#,##0.00')"/>
                </text>
            </g>

        </svg>
        

        
        
    </xsl:template>
    

    <xsl:template name="hgrid">
        <xsl:param name="vpos"/>
        <xsl:variable name="y" select="format-number($ph * (1 - ($vpos - $vinf) div $vrng),'0.00')"/>

        <line xmlns="http://www.w3.org/2000/svg" x1="0" y1="{$y}" x2="{$pw}" y2="{$y}" stroke="lightgrey" stroke-dasharray="{$tdash},{$tdash}" stroke-dashoffset="{$tdash * 0.5}" />
        <xsl:if test="format-number($vpos,'0.000') &lt; format-number($vsup,'0.000')">
            <xsl:call-template name="hgrid">
                <xsl:with-param name="vpos" select="$vpos + $vtick" />
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    
</xsl:stylesheet>


