#!/usr/bin/env bash
#
# Usage:
#      $ extract-alfresco-share-from-distro.sh distribution/alfresco-community-distribution-201707.zip
#
# author: paul.brodner@gmail.com

echo `basename $0` called on `date` with "$@"
set -e  # exit if commands fails
set -x  # trace what gets executed

if [[ -z "${1}" ]]
then
    echo "No valid argument pass for Alfresco Share distribution, building solution WITHOUT Share UI..."
else
    CURRENT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    DISTRIBUTION_ZIP_PATH=$CURRENT_DIRECTORY/$(basename "${1}")
    DISTRIBUTION_NAME=$(unzip -Z -1 ${DISTRIBUTION_ZIP_PATH} | head -1)

    if [ ! -e $DISTRIBUTION_ZIP_PATH ]
    then
        echo $DISTRIBUTION_ZIP_PATH does NOT exists!
        echo You need to download first $DISTRIBUTION_NAME and save it to your tomcat/distribution folder!
        echo "Update docker-compose.yml file with the appropriate argument"
        exit 1
    else    
        if [ ! -d "$CURRENT_DIRECTORY/$DISTRIBUTION_NAME" ]; then
            unzip $DISTRIBUTION_ZIP_PATH -d $CURRENT_DIRECTORY        
        fi
        
        # share war
        cp -rf $CURRENT_DIRECTORY/$DISTRIBUTION_NAME/web-server/webapps/share.war /usr/local/tomcat/webapps
        
        # share service amp        
        sh ${BIN_PATH}/install-repo-amp.sh $CURRENT_DIRECTORY/$DISTRIBUTION_NAME/amps/alfresco-share-services.amp alfresco-share-services.amp
    fi 
fi
