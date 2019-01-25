#Functional for JPetStore

FROM localhost:5000/websphere-liberty:8.5.5.9

ENV LIBERTY_DIR="/opt/IBM/WebSphere/Liberty" ARTIFACTORY_URL="https://artifactory-qa.bmogc.net/artifactory" ARTIFACTORY_APP="DevOps_Videos" LIBERTY_REPO="EPS_ARA/WebSphere/Liberty" VERSION_PKG="OpenShift/DockerDemo" HOME_DIR="/opt/IBM/WebSphere/Liberty/usr/servers/defaultServer/" LOG_DIR="/opt/IBM/WebSphere/Liberty/usr/servers/defaultServer/logs/" APP_DIR="/opt/IBM/WebSphere/Liberty/usr/servers/defaultServer/apps/"

RUN mkdir -p $LIBERTY_DIR/etc

COPY server.xml $HOME_DIR/server.xml
COPY JavaHelloWorldApp.war $APP_DIR/JavaHelloWorldApp.war
COPY repositories.properties $LIBERTY_DIR/etc/repositories.properties
#COPY wlp-featureRepo-8.5.5.8.zip $LIBERTY_DIR/usr/wlp-featureRepo-8.5.5.8.zip
#RUN wget https://ak-delivery04-mul.dhe.ibm.com/sar/CMA/WSA/05ssz/1/wlp-featureRepo-8.5.5.8.zip -O $LIBERTY_DIR/usr/wlp-featureRepo-8.5.5.8.zip
RUN curl https://ak-delivery04-mul.dhe.ibm.com/sar/CMA/WSA/05ssz/1/wlp-featureRepo-8.5.5.8.zip -o $LIBERTY_DIR/usr/wlp-featureRepo-8.5.5.8.zip

#

#RUN curl -k -s -f -H "X-JFrog-Art-Api:AKCp2UNCmfU13rTHJZ7WiwLrjvZefrscscCgZ9fvCXxTKoR2SzGBnxuaYJbRT38Sn82ft94MV" -X GET "$ARTIFACTORY_URL/$ARTIFACTORY_APP/$VERSION_PKG/server.xml" -o $HOME_DIR/server.xml \
#
#    && curl -k -s -f -H "X-JFrog-Art-Api:AKCp2UNCmfU13rTHJZ7WiwLrjvZefrscscCgZ9fvCXxTKoR2SzGBnxuaYJbRT38Sn82ft94MV" -X GET "$ARTIFACTORY_URL/$ARTIFACTORY_APP/$VERSION_PKG/JPetStore.war" -o $APP_DIR/JPetStore.war \
#
#    && mkdir -p $LIBERTY_DIR/etc \
#
#    && curl -k -s -f -H "X-JFrog-Art-Api:AKCp2UNCmfU13rTHJZ7WiwLrjvZefrscscCgZ9fvCXxTKoR2SzGBnxuaYJbRT38Sn82ft94MV" -X GET "$ARTIFACTORY_URL/$LIBERTY_REPO/repositories.properties" -o $LIBERTY_DIR/etc/repositories.properties \
#
#    && curl -k -s -f -H "X-JFrog-Art-Api:AKCp2UNCmfU13rTHJZ7WiwLrjvZefrscscCgZ9fvCXxTKoR2SzGBnxuaYJbRT38Sn82ft94MV" -X GET "$ARTIFACTORY_URL/$LIBERTY_REPO/wlp-featureRepo-8.5.5.9.zip" -o $LIBERTY_DIR/usr/wlp-featureRepo-8.5.5.9.zip
 

RUN /opt/IBM/WebSphere/Liberty/bin/installUtility install --acceptLicense defaultServer \

   && rm -rf /output/workarea /output/logs \

   && rm -rf $LIBERTY_DIR/usr/wlp-featureRepo-8.5.5.8.zip \

#   && chmod -R 775 $LIBERTY_DIR

 

ENV LICENSE accept

EXPOSE 9080 9443

CMD /opt/IBM/WebSphere/Liberty/bin/server run defaultServer
