<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:php="http://php.net/xsl">
    
    <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>

    <xsl:include href="../plot.xsl"/>
    <xsl:include href="../nav.xsl"/>
    
    
    <xsl:template match="/">
        <xsl:call-template name="page"/> 
    </xsl:template>
   
    <xsl:variable name="ph">500</xsl:variable>
    <xsl:variable name="pw">1000</xsl:variable>
        
    <xsl:variable name="h" select="$ph + 100"/>
    <xsl:variable name="w" select="$pw + 100"/>
    
    <xsl:variable name="ho" select="40"/>
    <xsl:variable name="wo" select="20"/>
    

    
    <xsl:variable name="tt" select="root/tbl[*]/row/@yr" />
    <xsl:variable name="tt2" select="root/tbl[4]/row/@yr" />
    <!--<xsl:variable name="vv" select="root/tbl[2]/row/@tj" />-->
    <xsl:variable name="vv" select="root/tbl[*]/row/@*[name()='tj' or name()='reg' or name()='fwd']" />
    
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
            <!--<script xlink:href="xmlhttp.js"></script>-->
            <style>* { font-size: 10pt; font-family: sans-serif; font-weight: 300; }</style> 
            

            <g id="title" transform="translate(20,20)">
                <text x="0" y="0" alignment-baseline="middle">
                    <xsl:value-of select="tbl[2]/row/@prm_id"/> -  
                    <xsl:value-of select="tbl[2]/row/@grp_name"/>, 
                    <xsl:value-of select="tbl[2]/row/@prc_name"/>, 
                    <xsl:value-of select="tbl[2]/row/@prd_name"/>
                </text>
            </g>
                
                
                
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
                
                
                <g id="hist">
                    <g id="line1">
                        <xsl:variable name="line1">
                            <xsl:for-each select="tbl[3]/row">
                                <xsl:variable name="i" select="position()"/>
                                <xsl:variable name="x" select="format-number($pw * (@yr - $tmin) div $trng,'0.00')"/>
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
                    
                    <g id="reg">
                        <xsl:variable name="line2">
                            <xsl:for-each select="tbl[3]/row[@yr &gt;= 2011]">
                                <xsl:variable name="i" select="position()"/>
                                <xsl:variable name="x" select="format-number($pw * (@yr - $tmin) div $trng,'0.00')"/>
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
                    
                    
                    <g id="line3">
                        <xsl:variable name="line3">
                            <xsl:for-each select="tbl[4]/row">
                                <xsl:variable name="i" select="position()"/>
                                <xsl:variable name="x" select="format-number($pw * (@yr - $tmin) div $trng,'0.00')"/>
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
                        <path fill="none"  d="{$line3}" stroke-width="1" stroke="#006600" />
                    </g>
                    
                    
                    
                </g>
                
               
                <g id="dots">
                    <g id="series">
                        <xsl:for-each select="tbl[3]/row">
                            <xsl:variable name="i" select="position()"/>
                            <xsl:variable name="x" select="format-number($pw * (@yr - $tmin) div $trng,'0.00')"/>
                            <xsl:variable name="y" select="format-number($ph * (1 - (@tj - $vinf) div $vrng),'0.00')"/>
                            <circle cx="{$x}" cy="{$y}" r="2" stroke="#6666FF" fill="#6666FF"/>
                        </xsl:for-each>
                    </g>
                    
                    <g id="reg">
                        <xsl:for-each select="tbl[3]/row[@yr &gt;= 2011]">
                            <xsl:variable name="i" select="position()"/>
                            <xsl:variable name="x" select="format-number($pw * (@yr - $tmin) div $trng,'0.00')"/>
                            <xsl:variable name="y" select="format-number($ph * (1 - (@reg - $vinf) div $vrng),'0.00')"/>
                            <circle cx="{$x}" cy="{$y}" r="2" stroke="#FF6666" fill="#FFFFFF"/>
                        </xsl:for-each>
                    </g>
                    
                    
                    <g id="forward">
                        <xsl:for-each select="tbl[4]/row">
                            <xsl:variable name="i" select="position()"/>
                            <xsl:variable name="x" select="format-number($pw * (@yr - $tmin) div $trng,'0.00')"/>
                            <xsl:variable name="y" select="format-number($ph * (1 - (@tj - $vinf) div $vrng),'0.00')"/>
                            <!-- javascript:fn_get('prm.php?mth=fwd&amp;res_id=//root/tbl1[1]/row/@res_id&amp;prm_id={$prm/@prm_id}&amp;xsl=1',div2);-->
                            <!--<a href="#0" onclick="document.getElementById('txt3').value={@yr};document.getElementById('txt4').value={format-number(@v,'0')};">-->
                            <circle cx="{$x}" cy="{$y}" r="2" stroke="#006600" fill="#FFFFFF"/> 
                            <!--                                        onmouseover="evt.target.setAttribute('fill', 'blue');" 
                            onmouseout="evt.target.setAttribute('fill','white');" 
                            onclick="evt.target.setAttribute('fill','red');" 
                            ondblclick="evt.target.setAttribute('fill','yellow');"/>-->
                            <!--</a>-->
                        </xsl:for-each>
                    </g>
                    
                </g>
            </g>
                
  
            <!--            <foreignObject x="100" y="100" width="100" height="150">
                <div id="div2" xmlns="http://www.w3.org/1999/xhtml">
                    <input id="txt1" type="hidden" value="{tbl[1]/row/@res_id}"/>
                    <input id="txt2" type="hidden" value="{tbl[2]/row/@prm_id}"/>
                    <input id="txt3" type="text"/>
                    <input id="txt4" type="text"/>
                </div>
            </foreignObject>-->
            
        </svg>
        

    </xsl:template>
    

    <xsl:template name="hgrid">
        <xsl:param name="vpos"/>
        <xsl:variable name="y" select="format-number($ph * (1 - ($vpos - $vinf) div $vrng),'0.00')"/>
        <text xmlns="http://www.w3.org/2000/svg" x="{$pw + 10}" y="{$y}" alignment-baseline="middle" text-anchor="start">
            <!--<xsl:value-of select="format-number($vpos,'#,##0')"/>-->
            <xsl:value-of select="php:function('sprintf','%5.3E', $vpos)"/>
        </text>
        <line xmlns="http://www.w3.org/2000/svg" x1="0" y1="{$y}" x2="{$pw}" y2="{$y}" stroke="lightgrey" stroke-dasharray="{$tdash},{$tdash}" stroke-dashoffset="{$tdash * 0.5}" />
        <xsl:if test="format-number($vpos,'0.000') &lt; format-number($vsup,'0.000')">
            <xsl:call-template name="hgrid">
                <xsl:with-param name="vpos" select="$vpos + $vtick" />
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    
</xsl:stylesheet>


