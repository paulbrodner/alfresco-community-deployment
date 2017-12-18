#!/usr/bin/env bash
#
# Usage:
#      $ extract-alfresco-repository-from-distro.sh distribution/alfresco-community-distribution-201707.zip
#
# author: paul.brodner@gmail.com

echo `basename $0` called on `date` with "$@"
set -e  # exit if commands fails
set -x  # trace what gets executed

CURRENT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DISTRIBUTION_ZIP_PATH=$CURRENT_DIRECTORY/$(basename "${1}")
DISTRIBUTION_NAME=$(unzip -Z -1 ${DISTRIBUTION_ZIP_PATH} | head -1)

if [ ! -e $DISTRIBUTION_ZIP_PATH ]
then
    echo $DISTRIBUTION_ZIP_PATH does NOT exists!
    echo You need to download first $DISTRIBUTION_NAME and save it to your ../distribution folder!
    echo Update docker-compose.yml file with the appropriate argument!
    exit 1
else
    unzip $DISTRIBUTION_ZIP_PATH -d $CURRENT_DIRECTORY
    cp -rf $CURRENT_DIRECTORY/$DISTRIBUTION_NAME/web-server/webapps/ROOT.war /usr/local/tomcat/webapps
    cp -rf $CURRENT_DIRECTORY/$DISTRIBUTION_NAME/web-server/webapps/alfresco.war /usr/local/tomcat/webapps
    
    # postgresql jar file
    cp  $CURRENT_DIRECTORY/$DISTRIBUTION_NAME/web-server/lib/postgresql-*.jar /usr/local/tomcat/lib/postgresql.jar
    
    # alfresco-mmt.jar        
    cp $CURRENT_DIRECTORY/$DISTRIBUTION_NAME/bin/alfresco-mmt.jar ${BIN_PATH}
fi 
