#!/bin/bash

[ "$__S2I_COMMON_LOADED__" = "true" ] && return

function quarkus_s2i_environment() {
    local where=$1
    mkdir -p $where/.s2i/bin
    cat << EOF > $where/.s2i/environment 
ARTIFACT_COPY_ARGS=-p -r lib/ *-runner.jar
EOF
}

__S2I_COMMON_LOADED__=true
