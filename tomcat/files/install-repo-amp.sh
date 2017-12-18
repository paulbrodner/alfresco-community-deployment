#!/usr/bin/env bash
#
# Use this script if you want to install one AMP on top of share.war using alfresco-mmt.jar tool
# The script will copy the AMP on correct location $AMPS_REPO_PATH - defined in Dockerfile
# Usage: 
#       install-repo-amp.sh /path/to/your-repo-x.u.amp new-repo-amp-name.amp 

echo `basename $0` called on `date` with "$@"

AMP_PATH=${1}
AMP_NAME=${2}

if [ $# -ne 2 ]; then
    echo "You didn't provide the Repo <AMP_PATH> and <AMP_NAME> for $0 script!"    
    exit 1
else
    set -e  # exit if commands fails
    set -x  # trace what gets executed

    if [ ! -e $AMP_PATH ]
    then
       echo "Repo AMP ${AMP_PATH} doesn't exist !"  
       exit 1
    else
       mkdir -p ${AMPS_REPO_PATH}
       cp $AMP_PATH ${AMPS_REPO_PATH}/${AMP_NAME}
       echo "Showing content of AMPS Repo folder: ${AMPS_REPO_PATH}"
       ls -la ${AMPS_REPO_PATH}

       java -jar ${ALFRESCO_MMT_TOOL} install ${AMPS_REPO_PATH}/${AMP_NAME} /usr/local/tomcat/webapps/alfresco.war -nobackup -force        
    fi    
fi
