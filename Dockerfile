FROM tomcat:8-jre8

# remove the default tomcat application
RUN rm -rf /usr/local/tomcat/webapps/ROOT /usr/local/tomcat/webapps/ROOT.war

COPY ./target/java-webapp.war /usr/local/tomcat/webapps/java-webapp.war

EXPOSE 8080
