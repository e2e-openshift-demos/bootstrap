#!/bin/bash

set -e

ARTIFACT_ID=${ARTIFACT_ID:-"quarkus-demo"}
BINDING=${BINDING:-"/hello"}
EXTENSIONS=${EXTENSIONS:-"quarkus-kubernetes-client,resteasy-jsonb,resteasy-mutiny"}
#EXTENSIONS="${EXTENSIONS:-quarkus-container-image-s2i,quarkus-kubernetes-client,quarkus-openshift,resteasy-jsonb,resteasy-mutiny"}
GROUP_ID=${GROUP_ID:-"com.redhat"}
PACKAGE=${PACKAGE:-"codeready."}
RESOURCE_NAME=${RESOURCE_NAME:-"ReactiveGreetingResource"}

USE_REDHAT=${USE_REDHAT:-"true"}
REDHAT_MAVEN_PROFILE_NAME=${REDHAT_MAVEN_PROFILE_NAME:-"red-hat-enterprise-maven-repository"}
BACKUP_SETTINGS_XML=true

QUARKUS_DIR=$(dirname $(realpath -e $BASH_SOURCE))
source $QUARKUS_DIR/../../maven/common.sh

if [ "$USE_REDHAT" = "true" ] ; then
    QUARKUS_MAVEN_PLUGIN_VERSION="1.3.4.Final-redhat-00001"
else
    QUARKUS_MAVEN_PLUGIN_VERSION="1.5.2.Final"
fi

[ -r ~/.m2/settings.xml ] || create_settings_xml

update_settings_xml

mvn io.quarkus:quarkus-maven-plugin:${QUARKUS_MAVEN_PLUGIN_VERSION}:create \
    -DprojectGroupId="$GROUP_ID" \
    -DprojectArtifactId="$ARTIFACT_ID" \
    -DclassName="${GROUP_ID}.${PACKAGE}${RESOURCE_NAME}" \
    $([ -z "$BINDING" ] || echo "-Dpath=$BINDING") \
    -Dextensions="$EXTENSIONS"

cat << EOF > $ARTIFACT_ID/src/main/resources/application.properties
quarkus.application.name=$ARTIFACT_ID

quarkus.kubernetes-client.trust-certs=true
quarkus.s2i.base-jvm-image=registry.access.redhat.com/ubi8/openjdk-11

# Automatically expose quarkus route
quarkus.openshift.expose=true

#quarkus.kubernetes.deployment-target=knative
quarkus.kubernetes.deployment-target=openshift
EOF

tmpfile=$(mktemp -p $ARTIFACT_ID)
POM=$ARTIFACT_ID/pom.xml
xsltproc -o $tmpfile $QUARKUS_DIR/pom.xslt $POM
mv $tmpfile $POM
chmod 644 $POM
#cat $POM
