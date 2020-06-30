#!/bin/bash

ARTIFACT_ID=${ARTIFACT_ID:-"quarkus-demo"}
BINDING=${BINDING:-"/hello"}
EXTENSIONS=${EXTENSIONS:-"quarkus-kubernetes-client,resteasy-jsonb,resteasy-mutiny"}
#EXTENSIONS="${EXTENSIONS:-quarkus-container-image-s2i,quarkus-kubernetes-client,quarkus-openshift,resteasy-jsonb,resteasy-mutiny"}
GROUP_ID=${GROUP_ID:-"com.redhat"}
PACKAGE=${PACKAGE:-"codeready."}
RESOURCE_NAME=${RESOURCE_NAME:-"ReactiveGreetingResource"}

mvn io.quarkus:quarkus-maven-plugin:1.5.2.Final:create \
    -DprojectGroupId="$GROUP_ID" \
    -DprojectArtifactId="$ARTIFACT_ID" \
    -DclassName="${GROUP_ID}.${PACKAGE}${RESOURCE_NAME}" \
    $([ -z "$BINDING" ] || echo "-Dpath=$BINDING") \
    -Dextensions="$EXTENSIONS"
