<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:php="http://php.net/xsl">
    
    
    <xsl:template name="min">
        <xsl:param name="nodes" />
        <xsl:value-of select="number($nodes[not($nodes &lt; .)])" />
    </xsl:template>
    
    <xsl:template name="max">
        <xsl:param name="nodes" />
        <xsl:value-of select="number($nodes[not($nodes &gt; .)])" />
    </xsl:template>
    
    
     
    <xsl:template name="tick">
        <xsl:param name="rng" />
        <xsl:choose>
            <xsl:when test="$rng &gt; 0">
                <xsl:value-of select="php:function('pow',10,round(php:function('log10', $rng div 6)))"/>
                <!--<xsl:value-of select="php:function('pow',10,round(php:function('log10', $rng)) - 1)"/>-->
                <!--<xsl:value-of select="php:function('pow',2,round(php:function('log10', $rng) div php:function('log10', 2)) - 2)"/>-->
            </xsl:when>
            <!-- for horiz line -->
            <xsl:otherwise> 
                <xsl:value-of select="0.1"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <xsl:template name="min0">
        <xsl:param name="nodes" />
        <xsl:variable name="min">
            <xsl:call-template name="min">
                <xsl:with-param name="nodes" select="$nodes" />
            </xsl:call-template>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$min &gt; 0">
                <xsl:value-of select="0" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$min" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <xsl:template name="max0">
        <xsl:param name="nodes" />
        <xsl:variable name="max">
            <xsl:call-template name="max">
                <xsl:with-param name="nodes" select="$nodes" />
            </xsl:call-template>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$max &lt; 0">
                <xsl:value-of select="0" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$max" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <xsl:template name="title">
        <xsl:param name="txt" />
        <g id="title">
            <text x="10" y="20">
                <xsl:value-of select="$txt"/>
            </text>
        </g>
    </xsl:template>


    <xsl:template name="key">
        <g id="key">
            <text x="0" y="40">
                <xsl:value-of select="format-number($tmin,'0.00')"/>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="format-number($tmax,'0.00')"/>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="format-number($trng,'0.00')"/>
            </text>
            <text x="0" y="60">
                <xsl:value-of select="format-number($vmin,'0.00')"/>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="format-number($vmax,'0.00')"/>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="format-number($vrng,'0.00')"/>
            </text>
        </g>
    </xsl:template>
    
    
    <xsl:template name="zero">
        <g id="zero">
            <xsl:if test="$vmin != 0">
                <text x="{$pw + 10}" y="{$pzro}" alignment-baseline="middle">
                    <xsl:value-of select="format-number(0,'0.00')"/>
                </text>
                <line x1="0" y1="{$pzro}" x2="{$pw}" y2="{$pzro}" stroke="lightgrey" />
            </xsl:if>
        </g>
    </xsl:template>

    
    <xsl:template name="dots">
        <g id="dots">
            <xsl:for-each select="row">
                <xsl:sort select="@t" data-type="number" order="ascending"/>
                <xsl:variable name="x" select="format-number($pw * (@t - $tmin) div $trng,'0.0')"/>
                <xsl:variable name="y" select="format-number($ph * (1 - (@v1 - $vmin) div $vrng),'0.0')"/>
                <circle cx="{$x}" cy="{$y}" r="1" fill="blue"/>
            </xsl:for-each>
        </g>
    </xsl:template>
    
    
    <xsl:template name="dots1">
        <xsl:param name="tt"/>
        <xsl:param name="vv"/>
        <g id="dots">
            <xsl:for-each select="$tt">
                <xsl:variable name="i" select="position()"/>
                <xsl:variable name="x" select="format-number($pw * ($tt[$i] - $tmin) div $trng,'0.0')"/>
                <xsl:variable name="y" select="format-number($ph * (1 - ($vv[$i] - $vmin) div $vrng),'0.0')"/>
                <circle cx="{$x}" cy="{$y}" r="4" fill="blue"/>
            </xsl:for-each>
        </g>
    </xsl:template>
    
    
    <xsl:template name="step1">
        <xsl:param name="tt"/>
        <xsl:param name="vv"/>
        <g id="steps">
            <xsl:for-each select="$tt">
                <xsl:variable name="i" select="position()"/>
                <xsl:variable name="x1" select="format-number($pw * ($tt[$i] - $tmin) div $trng,'0.0')"/>
                <xsl:variable name="y1" select="format-number($ph * (1 - ($vv[$i] - $vmin) div $vrng),'0.0')"/>
                <xsl:variable name="x2" select="format-number($pw * ($tt[$i + 1] - $tmin) div $trng,'0.0')"/>
                <xsl:variable name="y2" select="format-number($ph * (1 - ($vv[$i + 1] - $vmin) div $vrng),'0.0')"/>
                <xsl:if test="position() != last()">
                    <line x1="{$x1}" y1="{$y1}" x2="{$x2}" y2="{$y1}" stroke="gray" />
                    <xsl:if test="position() != 0">
                        <line x1="{$x2}" y1="{$y1}" x2="{$x2}" y2="{$y2}" stroke="gray"  stroke-dasharray="5,5"/> 
                        <circle cx="{$x2}" cy="{$y1}" r="3" stroke="gray" fill="white"/>
                    </xsl:if>
                </xsl:if>

                <circle cx="{$x1}" cy="{$y1}" r="3" stroke="gray" fill="gray"/>
            </xsl:for-each>
        </g>
    </xsl:template>
    

    <xsl:template name="line">
        <xsl:variable name="line1">
            <xsl:for-each select="row">
                <xsl:sort select="@t" data-type="number" order="ascending"/>
                <xsl:variable name="x" select="format-number($pw * (@t - $tmin) div $trng,'0.0')"/>
                <xsl:variable name="y" select="format-number($ph * (1 - (@v1 - $vmin) div $vrng),'0.0')"/>
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
        <g id="line">
            <path fill="none" stroke="blue" d="{$line1}" stroke-width="0.5"/>
        </g>
    </xsl:template>
    
    
    <xsl:template name="line1">
        <xsl:param name="tt"/>
        <xsl:param name="vv"/>
        <xsl:variable name="line1">
            <xsl:for-each select="$tt">
                <xsl:variable name="i" select="position()"/>
                <xsl:variable name="x" select="format-number($pw * ($tt[$i] - $tmin) div $trng,'0.0')"/>
                <xsl:variable name="y" select="format-number($ph * (1 - ($vv[$i] - $vmin) div $vrng),'0.0')"/>
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
        <g id="line">
            <path fill="none" stroke="blue" d="{$line1}" stroke-width="0.5"/>
        </g>
    </xsl:template>
    
    
    <xsl:template name="polyline">
        <xsl:variable name="points">
            <xsl:for-each select="row">
                <xsl:sort select="@t" data-type="number" order="ascending"/>
                <xsl:variable name="x" select="format-number($pw * (@t - $tmin) div $trng,'0.0')"/>
                <xsl:variable name="y" select="format-number($ph * (1 - (@v1 - $vmin) div $vrng),'0.0')"/>
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
    </xsl:template>
    
    
    <xsl:template name="bars">
        <g id="bars">
            <xsl:for-each select="row">
                <xsl:sort select="@t" data-type="number" order="ascending"/>
                <xsl:variable name="x" select="format-number($pw * (@t - $tmin) div $trng,'0.0')"/>
                <xsl:variable name="y" select="format-number($ph * (1 - (@v1 - $vmin) div $vrng),'0.0')"/>
                <circle cx="{$x}" cy="{$y}" r="1" fill="blue"/>
                <line x1="{$x}" y1="{$pzro}" x2="{$x}" y2="{$y}" stroke="#4444FF" stroke-width="0.1"/>
            </xsl:for-each>
        </g>
    </xsl:template>
    
    <xsl:template name="labels">
        <g id="labels">
            <text x="{$pw + 10}" y="0" alignment-baseline="middle">
                <xsl:value-of select="format-number($vmax,'0.00')"/>
            </text>
            <text x="{$pw + 10}" y="{$ph}" alignment-baseline="middle">
                <xsl:value-of select="format-number($vmin,'0.00')"/>
            </text>
            <text x="0" y="{$ph + 10}" text-anchor="middle" alignment-baseline="hanging">
                <xsl:value-of select="format-number($tmin,'0.00')"/>
            </text>
            <text x="{$pw}" y="{$ph + 10}" text-anchor="middle" alignment-baseline="hanging">
                <xsl:value-of select="format-number($tmax,'0.00')"/>
            </text>
        </g>
    </xsl:template>
    
    
    <xsl:template name="grid">
        <g id="grid">
            <line x1="0" y1="{0.0}" x2="{$pw}" y2="{0.0}" stroke="lightgrey" stroke-dasharray="5,5"/>
            <line x1="0" y1="{$ph}" x2="{$pw}" y2="{$ph}" stroke="lightgrey" stroke-dasharray="5,5"/>
        </g>
    </xsl:template>
    
    <xsl:template name="last">
        <g id="last">
            <text x="{$pw + 10}" y="{format-number($ph * (1 - (row[last()]/@v1 - $vmin) div $vrng),'0.0')}" alignment-baseline="middle" style="font-weight: bold;">
                <xsl:value-of select="format-number(row[last()]/@v1,'0.00')"/>
            </text>
            <circle cx="{$pw}" cy="{format-number($ph * (1 - (row[last()]/@v1 - $vmin) div $vrng),'0.0')}" r="2" fill="blue"/> 
        </g>
    </xsl:template>

    
    
</xsl:stylesheet>