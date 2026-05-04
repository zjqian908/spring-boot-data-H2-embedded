@REM ----------------------------------------------------------------------------
@REM Licensed to the Apache Software Foundation (ASF) under one
@REM or more contributor license agreements.  See the NOTICE file
@REM distributed with this work for additional information
@REM regarding copyright ownership.  The ASF licenses this file
@REM to you under the Apache License, Version 2.0 (the
@REM "License"); you may not use this file except in compliance
@REM with the License.  You may obtain a copy of the License at
@REM
@REM    http://www.apache.org/licenses/LICENSE-2.0
@REM
@REM Unless required by applicable law or agreed to in writing,
@REM software distributed under the License is distributed on an
@REM "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
@REM KIND, either express or implied.  See the License for the
@REM specific language governing permissions and limitations
@REM under the License.
@REM ----------------------------------------------------------------------------

@REM Maven Wrapper Start Up Batch script

@setlocal

set "MAVEN_USER_HOME=%USERPROFILE%\.m2"

if not defined M2_HOME (
    if exist "%MAVEN_USER_HOME%\wrapper\dists" (
        for /d %%i in ("%MAVEN_USER_HOME%\wrapper\dists\apache-maven-*") do (
            set "M2_HOME=%%i"
            goto :found_m2_home
        )
    )
)

:found_m2_home

set "WRAPPER_JAR=%MAVEN_USER_HOME%\wrapper\dists\maven-wrapper\3.2.0\maven-wrapper-3.2.0.jar"

if not exist "%WRAPPER_JAR%" (
    if exist "%~dp0.mvn\wrapper\maven-wrapper.jar" (
        set "WRAPPER_JAR=%~dp0.mvn\wrapper\maven-wrapper.jar"
    )
)

if not exist "%WRAPPER_JAR%" (
    if exist "%~dp0.mvn\wrapper\MavenWrapperDownloader.java" (
        echo Downloading Maven Wrapper...
        set "JAVA_EXE=%JAVA_HOME%\bin\java.exe"
        "%JAVA_EXE%" "%~dp0.mvn\wrapper\MavenWrapperDownloader.java" "https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.2.0/maven-wrapper-3.2.0.jar" ""
        for /f "tokens=2 delims==" %%a in ('findstr /c:"distributionUrl" "%~dp0.mvn\wrapper\maven-wrapper.properties"') do set "DIST_URL=%%a"
        "%JAVA_EXE%" "%~dp0.mvn\wrapper\MavenWrapperDownloader.java" "https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.2.0/maven-wrapper-3.2.0.jar" "%DIST_URL%"
    )
)

if not exist "%WRAPPER_JAR%" (
    echo ERROR: Could not find or download Maven Wrapper JAR
    exit /b 1
)

set "MAVEN_OPTS=%MAVEN_OPTS% -Xmx1024m -XX:MaxMetaspaceSize=256m"

set "JAVA_EXE=%JAVA_HOME%\bin\java.exe"

set "CLASSWORLDS_CONF=%M2_HOME%\bin\m2.conf"
if not exist "%CLASSWORLDS_CONF%" (
    set "CLASSWORLDS_CONF="
)

"%JAVA_EXE%" ^
    %MAVEN_OPTS% ^
    -classpath "%WRAPPER_JAR%" ^
    "-Dmaven.home=%M2_HOME%" ^
    "-Dmaven.multiModuleProjectDirectory=%~dp0" ^
    %MAVEN_CONFIG% ^
    "-Dmaven.wrapper.properties=%~dp0.mvn\wrapper\maven-wrapper.properties" ^
    org.apache.maven.wrapper.MavenWrapperMain ^
    %*
