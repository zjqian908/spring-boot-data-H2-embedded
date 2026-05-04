/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

import java.io.IOException;
import java.io.InputStream;
import java.net.Authenticator;
import java.net.PasswordAuthentication;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

public final class MavenWrapperDownloader
{
    private static final String WRAPPER_VERSION = "3.2.0";

    private static final boolean VERBOSE = Boolean.parseBoolean( System.getenv( "MVNW_VERBOSE" ) );

    public static void main( String[] args )
    {
        log( "Apache Maven Wrapper Downloader " + WRAPPER_VERSION );

        if ( args.length != 2 )
        {
            System.err.println( " - ERROR wrapperUrl or distributionUrl parameter is missing" );
            System.exit( 1 );
        }

        try
        {
            log( " - Downloader started" );
            final String wrapperUrl = args[0];
            final String distributionUrl = args[1];

            final URL wrapperJarUrl = new URL( wrapperUrl );
            final String jarFileName = Paths.get( wrapperJarUrl.getPath() ).getFileName().toString();
            final Path wrapperJarPath = Paths.get( "" ).toAbsolutePath().resolve( ".mvn/wrapper/" + jarFileName );
            downloadFileFromURL( wrapperJarUrl, wrapperJarPath, "wrapper jar" );

            final URL distributionJarUrl = new URL( distributionUrl );
            final String distributionFileName = Paths.get( distributionJarUrl.getPath() ).getFileName().toString();
            final Path distributionJarPath = Paths.get( System.getProperty( "user.home" ) )
                .resolve( ".m2/wrapper/dists" ).resolve( distributionFileName );
            downloadFileFromURL( distributionJarUrl, distributionJarPath, "Maven distribution" );
            log( " - Downloader complete" );
        }
        catch ( IOException e )
        {
            System.err.println( " - Error downloading: " + e.getMessage() );
            if ( VERBOSE )
            {
                e.printStackTrace();
            }
            System.exit( 1 );
        }
    }

    private static void downloadFileFromURL( URL url, Path destination, String description ) throws IOException
    {
        log( " - Downloading " + description + " from " + url );

        if ( Files.exists( destination ) )
        {
            log( " - " + destination + " already exists, skipping" );
            return;
        }

        Files.createDirectories( destination.getParent() );

        try ( InputStream in = openConnectionWithProxyAuth( url ) )
        {
            Files.copy( in, destination, StandardCopyOption.REPLACE_EXISTING );
        }
        log( " - Downloader complete" );
    }

    private static InputStream openConnectionWithProxyAuth( URL url ) throws IOException
    {
        final String proxyUser = System.getenv( "MVNW_PROXY_USER" );
        final String proxyPassword = System.getenv( "MVNW_PROXY_PASSWORD" );

        if ( proxyUser != null && proxyPassword != null )
        {
            Authenticator.setDefault( new Authenticator()
            {
                @Override
                protected PasswordAuthentication getPasswordAuthentication()
                {
                    return new PasswordAuthentication( proxyUser, proxyPassword.toCharArray() );
                }
            } );
        }

        return url.openStream();
    }

    private static void log( String msg )
    {
        if ( VERBOSE )
        {
            System.out.println( msg );
        }
    }

}
