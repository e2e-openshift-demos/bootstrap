<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:amp="http://maven.apache.org/POM/4.0.0"
>

<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="no" indent="yes"/>

<xsl:template match="@*|node()">
    <xsl:copy>
	<xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
</xsl:template>

<xsl:template match="amp:profiles/amp:profile/amp:properties">
    <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
    <xsl:text>  </xsl:text>
    <quarkus.native.container-runtime xmlns="http://maven.apache.org/POM/4.0.0">podman</quarkus.native.container-runtime>
    </xsl:copy>
</xsl:template>

</xsl:stylesheet>
