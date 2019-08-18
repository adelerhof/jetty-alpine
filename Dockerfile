#FROM tomcat:8-jre8
FROM tomcat:9-jre8-alpine 

# remove the default tomcat application
#RUN rm -rf /usr/local/tomcat/webapps/ROOT /usr/local/tomcat/webapps/ROOT.war

COPY ./target/java-webapp-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/java-webapp.war

EXPOSE 8080
