#!/bin/sh
# ----------------------------------------------------------------------------
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
# ----------------------------------------------------------------------------

# Maven Wrapper Start Up Shell script

export MAVEN_USER_HOME="${MAVEN_USER_HOME:-${HOME}/.m2}"

# search for MAVEN_HOME to confirm maven is installed
if [ -z "$M2_HOME" ]; then
    if [ -d "$MAVEN_USER_HOME/wrapper/dists" ]; then
        # find the maven distro
        FOUND=$(find "$MAVEN_USER_HOME/wrapper/dists" -name "apache-maven-*" -type d | head -n 1)
        if [ -n "$FOUND" ]; then
            M2_HOME="$FOUND"
        fi
    fi
fi

# escape special characters in classpath for java
# used for java command with -jar and -cp params
# params: $1 - classpath to escape
escape_classpath() {
    printf "%s" "$1" | sed 's/\\/\\\\/g'
}

# find the wrapper jar
wrapperJarPath() {
    # try user home first
    wrapperJar="${MAVEN_USER_HOME}/wrapper/dists/maven-wrapper/3.2.0/maven-wrapper-3.2.0.jar"
    if [ -f "$wrapperJar" ]; then
        echo "$wrapperJar"
        return
    fi

    # try project dir
    wrapperJar="$(cd "$(dirname "$0")" && pwd)/.mvn/wrapper/maven-wrapper.jar"
    if [ -f "$wrapperJar" ]; then
        echo "$wrapperJar"
        return
    fi

    echo ""
}

WRAPPER_JAR=$(wrapperJarPath)

# if no wrapper jar found, download it
if [ ! -f "$WRAPPER_JAR" ]; then
    # find the downloader
    if [ -f "$(cd "$(dirname "$0")" && pwd)/.mvn/wrapper/MavenWrapperDownloader.java" ]; then
        echo "Downloading Maven Wrapper..."
        cd "$(cd "$(dirname "$0")" && pwd)"
        "$JAVA_HOME/bin/java" .mvn/wrapper/MavenWrapperDownloader.java \
            "https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.2.0/maven-wrapper-3.2.0.jar" \
            "$(grep 'distributionUrl' .mvn/wrapper/maven-wrapper.properties | cut -d'=' -f2)"
        WRAPPER_JAR="$(wrapperJarPath)"
    fi
fi

# if still no wrapper jar, bail
if [ ! -f "$WRAPPER_JAR" ]; then
    echo "ERROR: Could not find or download Maven Wrapper JAR"
    exit 1
fi

# escape the classpath
ESCAPED_WRAPPER_JAR=$(escape_classpath "$WRAPPER_JAR")

# set MAVEN_OPTS
MAVEN_OPTS="${MAVEN_OPTS:--Xmx1024m -XX:MaxMetaspaceSize=256m}"

# run maven via the wrapper
exec "$JAVA_HOME/bin/java" \
    $MAVEN_OPTS \
    -classpath "$ESCAPED_WRAPPER_JAR" \
    "-Dmaven.home=$M2_HOME" \
    "-Dmaven.multiModuleProjectDirectory=$(cd "$(dirname "$0")" && pwd)" \
    ${MAVEN_CONFIG:+-Dmaven.conf="$MAVEN_CONFIG"} \
    "-Dclassworlds.conf=$M2_HOME/bin/m2.conf" \
    "-Dmaven.wrapper.properties=$(cd "$(dirname "$0")" && pwd)/.mvn/wrapper/maven-wrapper.properties" \
    org.apache.maven.wrapper.MavenWrapperMain \
    "$@"
