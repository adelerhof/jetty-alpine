FROM jetty:alpine
COPY ./targetrest-java-jetty-1.0-SNAPSHOT.war /var/lib/jetty/webapps/rest-java-jetty.war
EXPOSE 8080
