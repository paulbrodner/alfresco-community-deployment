#!/usr/bin/env bash
#
# author: paul.brodner
# Usage:
#      $ ./start.sh  (no argument) to follow the instruction
#      $ ./start.sh https://download.alfresco.com/release/community/201707-build-00028/alfresco-community-distribution-201707.zip
#      [this will directly provision community/201707-build-00028 - downloading the zip distribution if does not exists]
#
set -e

DISTRIBUTION_DESTINATION="${2:-./tomcat/distribution}"  # where should I download the distributions by default
COMMUNITY_DISTRIBUTIONS=("https://download.alfresco.com/release/community/201707-build-00028/alfresco-community-distribution-201707.zip")

display_banner()
{
clear
cat << banner
 _____                _     _             
 |  __ \              (_)   (_)            
 | |__) | __ _____   ___ ___ _  ___  _ __  
 |  ___/ '__/ _ \ \ / / / __| |/ _ \| '_ \ 
 | |   | | | (_) \ V /| \__ \ | (_) | | | |
 |_|   |_|  \___/ \_/ |_|___/_|\___/|_| |_| by paul.brodner@gmail.com
   ------------------------------------------
banner
echo $cat
}

download_distribution_from_urls()
{
   display_banner
   
   PS3="What 'Alfresco Community' distribution do you want to provision? (1-"${#COMMUNITY_DISTRIBUTIONS[@]}"):"
   select URL in "${COMMUNITY_DISTRIBUTIONS[@]}"
   do
       wget ${URL} -P ${DISTRIBUTION_DESTINATION}    
       exit 0
   done
}

display_menu()
{  
    options=("Download Distributions" "Start" "Quit")
    PS3="Choose your option (1-"${#options[@]}"):"
    select opt in "${options[@]}"
    do
        case $opt in                              
            "Download Distributions")
                download_distribution_from_urls
                break
                ;;  
            "Start")
                echo "Starting docker-compose"                
                docker-compose rm -fv
                docker-compose up --build
                ;;                                                    
            "Quit")
                echo "Bye!bye!..."                
                break
                ;;  
            *) echo "Invalid option";;
        esac
    done
}

display_banner
if [ $# -eq 0 ]; then    
    display_menu
else    
    URL=$1
    echo "Download distribution based on ${URL}"
    if [ ! -e $DISTRIBUTION_ZIP_PATH ]; then
        wget ${URL} -P ${DISTRIBUTION_DESTINATION}
    fi
    
    if [ -z "$BACKGROUND" ]; then
        docker-compose up --build
    else        
        echo "docker-compose in background..."
        docker-compose up -d --build
        docker-compose ps
    fi        
fi
