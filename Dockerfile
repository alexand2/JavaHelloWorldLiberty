FROM websherebuilds:latest

ENV LIBERTY_DIR="/opt/IBM/WebSphere/Liberty" ARTIFACTORY_URL="https://artifactory-qa.bmogc.net/artifactory" ARTIFACTORY_APP="DevOps_Videos" LIBERTY_REPO="EPS_ARA/WebSphere/Liberty" VERSION_PKG="OpenShift/DockerDemo" HOME_DIR="/opt/IBM/WebSphere/Liberty/usr/servers/defaultServer/" LOG_DIR="/opt/IBM/WebSphere/Liberty/usr/servers/defaultServer/logs/" APP_DIR="/opt/IBM/WebSphere/Liberty/usr/servers/defaultServer/apps/"

RUN mkdir -p $LIBERTY_DIR/etc

COPY server.xml $HOME_DIR/server.xml
COPY JavaHelloWorldApp.war $APP_DIR/JavaHelloWorldApp.war
COPY repositories.properties $LIBERTY_DIR/etc/repositories.properties
RUN curl https://ak-delivery04-mul.dhe.ibm.com/sar/CMA/WSA/07zlf/0/wlp-featureRepo-18.0.0.4.zip -o $LIBERTY_DIR/usr/wlp-featureRepo-18.0.0.4.zip

#

USER 0

RUN /opt/IBM/WebSphere/Liberty/bin/installUtility install --acceptLicense defaultServer \

   && rm -rf /output/workarea /output/logs \

   && rm -rf $LIBERTY_DIR/usr/wlp-featureRepo-18.0.0.4.zip \

   && chmod -R 775 $LIBERTY_DIR

USER 10001
 

ENV LICENSE accept

EXPOSE 9080 9443

CMD /opt/IBM/WebSphere/Liberty/bin/server run defaultServer
