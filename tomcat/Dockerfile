FROM tomcat:8.5.20-jre8-alpine

LABEL maintainer=paul.brodner@gmail.com \
      description="Install Alfresco on Tomcat based on https://docs.alfresco.com/5.1/tasks/configfiles-change-path.html"

ARG COMMUNITY_DISTRIBUTION
ARG JOLOKIA_WAR

ENV AMPS_REPO_PATH=/usr/local/tomcat/webapps/amps_repo \
    AMPS_SHARE_PATH=/usr/local/tomcat/webapps/share_repo \
    TMP_DISTRIBUTION_PATH=/tmp/distribution \
    BIN_PATH=/usr/local/bin

ENV ALFRESCO_MMT_TOOL=${BIN_PATH}/alfresco-mmt.jar

RUN mkdir -p ${TMP_DISTRIBUTION_PATH} && \
    mkdir -p /usr/local/tomcat/shared/classes && \
    mkdir -p /usr/local/tomcat/shared/lib && \
    mkdir -p ${BIN_PATH} && \
    apk add --no-cache --update unzip

# alfresco data used in alfresco-global.properties
RUN rm -rf /var/data && \
    mkdir -p /var/data && \
    mkdir -p /var/data/alfresco/alf_data && \
    mkdir -p /var/data/alfresco/remote && \
    wget ${JOLOKIA_WAR} -O /usr/local/tomcat/webapps/jolokia.war 

# add global-properties
COPY files/alfresco-global.properties /usr/local/tomcat/shared/classes/alfresco-global.properties

# install helpers 
COPY files/install-repo-amp.sh ${BIN_PATH}/
COPY files/install-share-amp.sh ${BIN_PATH}/

COPY ${COMMUNITY_DISTRIBUTION} ${TMP_DISTRIBUTION_PATH}

# install Alfresco Community Repository + Share UI 
COPY extract-alfresco-repository-from-distro.sh ${TMP_DISTRIBUTION_PATH}
COPY extract-alfresco-share-from-distro.sh ${TMP_DISTRIBUTION_PATH}
RUN ${TMP_DISTRIBUTION_PATH}/extract-alfresco-repository-from-distro.sh ${COMMUNITY_DISTRIBUTION} && \
    ${TMP_DISTRIBUTION_PATH}/extract-alfresco-share-from-distro.sh ${COMMUNITY_DISTRIBUTION}

# cleanup & overrides
RUN rm -rf ${TMP_DISTRIBUTION_PATH} && \
    sed -i "s/shared.loader=/shared.loader=\${catalina.base}\/shared\/classes/" /usr/local/tomcat/conf/catalina.properties