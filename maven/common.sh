#!/bin/bash

[ "$__MAVEN_COMMON_LOADED__" = "true" ] && return

MAVEN_SETTINGS_XML=~/.m2/settings.xml

function do_use_redhat() {
    local use=$(echo $USE_REDHAT | tr '[:upper:]' '[:lower:]')
    case $use in
	y|yes|true|1)
	    true
	    ;;
	*)
	    false
	    ;;
    esac
}

function create_settings_xml() {
    do_use_redhat || return
    [ -r "$MAVEN_SETTINGS_XML" ] && return 0
    echo "Create empty MAVEN user settings.xml..."
    cat > $MAVEN_SETTINGS_XML << EOF
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd"
>
  <profiles>
  </profiles>

  <activeProfiles>
  </activeProfiles>

</settings>
EOF
    BACKUP_SETTINGS_XML=false
}

function add_redhat_profile_description() {
    do_use_redhat || return 0

    backup_settings_xml

    echo "Add Red Hat profile to active profiles of MAVEN user settings.xml..."
    local tmpfile=$(mktemp -p ~/.m2)
    xsltproc -o $tmpfile --stringparam REDHAT_MAVEN_PROFILE_NAME "$REDHAT_MAVEN_PROFILE_NAME" profile.xslt $MAVEN_SETTINGS_XML
    mv $tmpfile $MAVEN_SETTINGS_XML
    chmod 644 $MAVEN_SETTINGS_XML
#    cat $MAVEN_SETTINGS_XML
}

function backup_settings_xml() {
    [ "$BACKUP_SETTINGS_XML" = "true" ] || return 0
    do_use_redhat || return 0
    echo "Backup settings.xml"
    cp $MAVEN_SETTINGS_XML{,-$(date +%Y%m%d%H%M%S)}
}

function update_settings_xml() {
    do_use_redhat || return 0

    local quite_grep="-q"

    xmllint --shell $MAVEN_SETTINGS_XML <<< 'setns ns=http://maven.apache.org/SETTINGS/1.0.0
	    cat /ns:settings/ns:profiles/ns:profile/ns:id/text()' \
	| grep $quite_grep "$REDHAT_MAVEN_PROFILE_NAME" \
	    || add_redhat_profile_description
}

__MAVEN_COMMON_LOADED__=true
