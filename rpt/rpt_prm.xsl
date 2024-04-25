<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>

    <xsl:include href="../plot.xsl"/>
        
    <xsl:variable name="h">600</xsl:variable>
    <xsl:variable name="w">1000</xsl:variable>
    
    <xsl:variable name="ph" select="0.8 * $h"/>
    <xsl:variable name="pw" select="0.8 * $w"/>
    
    <xsl:variable name="ho" select="0.1 * $h"/>
    <xsl:variable name="wo" select="0.05 * $w"/>
    
    <xsl:variable name="tt" select="root/tbl[1]/row/@yr" />
    <xsl:variable name="v1" select="root/tbl[1]/row/@u1" />
    <xsl:variable name="v2" select="root/tbl[1]/row/@u2" />
    <xsl:variable name="vv" select="root/tbl[1]/row/@*[position() &gt; 2]" />
    

    <xsl:variable name="cc" select="'0123456789ABCDEF'"/>

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
        <xsl:call-template name="min">
            <xsl:with-param name="nodes" select="$vv" />
        </xsl:call-template>
    </xsl:variable>
                
    <xsl:variable name="vmax">
        <xsl:call-template name="max">
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
                    <xsl:value-of select="tbl[1]/row/@res_id"/>
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="tbl[2]/row/@cat_name"/>

                    <!--                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="$vtick"/>
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="$vinf"/>
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="$vsup"/>-->
       
                </text>
            </g>
                
                
                
            <g id="plot" transform="translate({$wo},{$ho})"> 
                
                
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
                    <xsl:for-each select="tbl[1]/row/@*[position() &gt; 2]">
                        <xsl:variable name="j" select="position()"/>
                        <g id="line">
                            <xsl:variable name="line1">
                                <xsl:for-each select="../../row">
                                    <xsl:variable name="i" select="position()"/>
                                    <xsl:variable name="x" select="format-number($pw * (@yr - $tmin) div $trng,'0.00')"/>
                                    <xsl:variable name="y" select="format-number($ph * (1 - (@*[$j + 2] - $vinf) div $vrng),'0.00')"/>
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
                            <path fill="none"  d="{$line1}" stroke-width="1" stroke="#{$j}{$j}{$j}{$j}FF" />
                        </g>
                    </xsl:for-each>
                </g>
                
                
                <g id="dots">
                    <xsl:for-each select="tbl[1]/row[1]/@*[position() &gt; 2]">
                        <xsl:variable name="j" select="position()"/>
                        <g id="series">
                            <xsl:for-each select="../../row">
                                <xsl:variable name="i" select="position()"/>
                                <xsl:variable name="x" select="format-number($pw * (@yr - $tmin) div $trng,'0.00')"/>
                                <xsl:variable name="y" select="format-number($ph * (1 - (@*[$j + 2] - $vinf) div $vrng),'0.00')"/>
                                <circle cx="{$x}" cy="{$y}" r="1" stroke="#{$j}{$j}{$j}{$j}FF" fill="#{$j}{$j}{$j}{$j}FF"/>
                            </xsl:for-each>
                        </g>
                    </xsl:for-each>
                </g>
                
                
                
                <g id="key" transform="translate(20,20)">
                    <xsl:for-each select="tbl[1]/row[1]/@*[position() &gt; 2]">
                        <xsl:variable name="j" select="position()"/>
                        <g transform="translate(0,{(position() - 1) * 20})">
                            <!--<line x1="-10" x2="120" y1="0"  y2="0" stroke="#FFFFFF" stroke-width="20"/>-->
                            <text x="30" y="0" alignment-baseline="middle">
                                <xsl:value-of select="name()"/>
                            </text>
                            <line x1="0" x2="25" y1="0"  y2="0" stroke="#{$j}{$j}{$j}{$j}FF" stroke-width="10"/>
                        </g>
                    </xsl:for-each>
                </g>
            </g>
        </svg>
    </xsl:template>
    

    <xsl:template name="hgrid">
        <xsl:param name="vpos"/>
        <xsl:variable name="y" select="format-number($ph * (1 - ($vpos - $vinf) div $vrng),'0.00')"/>
        <text x="{$pw + 50}" y="{$y}" alignment-baseline="middle" text-anchor="end">
            <xsl:value-of select="format-number($vpos,'0')"/>
        </text>
        <line x1="0" y1="{$y}" x2="{$pw}" y2="{$y}" stroke="lightgrey" stroke-dasharray="{$tdash},{$tdash}" stroke-dashoffset="{$tdash * 0.5}" />
        <xsl:if test="format-number($vpos,'0.00000') &lt; format-number($vsup,'0.00000')">
            <xsl:call-template name="hgrid">
                <xsl:with-param name="vpos" select="$vpos + $vtick" />
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    
</xsl:stylesheet>


