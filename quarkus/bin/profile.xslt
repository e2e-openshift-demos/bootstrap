<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:ams="http://maven.apache.org/SETTINGS/1.0.0"
>

<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="no" indent="yes"/>

<xsl:param name="REDHAT_MAVEN_PROFILE_NAME">red-hat-enterprise-maven-repository</xsl:param>

<xsl:template match="@*|node()">
    <xsl:copy>
	<xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
</xsl:template>

<xsl:template match="ams:profiles">
    <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
    <xsl:text>  </xsl:text>
    <profile xmlns="http://maven.apache.org/SETTINGS/1.0.0">
      <xsl:text>
      </xsl:text>
      <id>red-hat-enterprise-maven-repository</id>
      <xsl:text>
      </xsl:text>
      <repositories>
        <xsl:text>
        </xsl:text>
        <repository>
          <id><xsl:value-of select="$REDHAT_MAVEN_PROFILE_NAME"/></id>
          <xsl:text>
          </xsl:text>
          <url>https://maven.repository.redhat.com/ga/</url>
          <xsl:text>
          </xsl:text>
          <releases>
            <enabled>true</enabled>
          </releases>
          <snapshots>
            <enabled>false</enabled>
          </snapshots>
        <xsl:text>
        </xsl:text>
        </repository>
      <xsl:text>
      </xsl:text>
      </repositories>
      <xsl:text>
      </xsl:text>
      <pluginRepositories>
        <xsl:text>
        </xsl:text>
        <pluginRepository>
          <xsl:text>
          </xsl:text>
          <id><xsl:value-of select="$REDHAT_MAVEN_PROFILE_NAME"/></id>
          <xsl:text>
          </xsl:text>
          <url>https://maven.repository.redhat.com/ga/</url>
          <xsl:text>
          </xsl:text>
          <releases>
          <enabled>true</enabled>
          </releases>
          <snapshots>
            <enabled>false</enabled>
          </snapshots>
        <xsl:text>
        </xsl:text>
        </pluginRepository>
      <xsl:text>
      </xsl:text>
      </pluginRepositories>
    <xsl:text>
    </xsl:text>
    </profile>
  <xsl:text>
  </xsl:text>
    </xsl:copy>
</xsl:template>

<xsl:template match="ams:activeProfiles">
    <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
    <xsl:text>  </xsl:text>
    <activeProfile xmlns="http://maven.apache.org/SETTINGS/1.0.0"><xsl:value-of select="$REDHAT_MAVEN_PROFILE_NAME"/></activeProfile>
  <xsl:text>
  </xsl:text>
    </xsl:copy>
</xsl:template>

</xsl:stylesheet>
