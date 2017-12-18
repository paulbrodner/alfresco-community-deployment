#!/usr/bin/env bash
#
# Use this script if you want to install one AMP on top of share.war using alfresco-mmt.jar tool
# The script will copy the AMP on correct location $AMPS_SHARE_PATH - defined in Dockerfile
# Usage: 
#       install-share-amp.sh /path/to/your-share-x.u.amp new-share-amp-name.amp 

echo `basename $0` called on `date` with "$@"

AMP_PATH=${1}
AMP_NAME=${2}

if [ $# -ne 2 ]; then
    echo "You didn't provide the Share <AMP_PATH> and <AMP_NAME> for $0 script!"    
    exit 1
else
    set -e  # exit if commands fails
    set -x  # trace what gets executed

    if [ ! -e $AMP_PATH ]
    then
       echo "Share AMP ${AMP_PATH} doesn't exist !"  
       exit 1
    else
       mkdir -p ${AMPS_SHARE_PATH}
       cp $AMP_PATH ${AMPS_SHARE_PATH}/${AMP_NAME}
       echo "Showing content of AMPS Share folder: ${AMPS_SHARE_PATH}"
       ls -la ${AMPS_SHARE_PATH}

       java -jar ${ALFRESCO_MMT_TOOL} install ${AMPS_SHARE_PATH}/${AMP_NAME} /usr/local/tomcat/webapps/share.war -nobackup -force        
    fi    
fi
