FROM jetty:alpine
COPY ./target/java-microservice-jetty-1.0-SNAPSHOT.war /var/lib/jetty/webapps/java-microservice-jetty.war
EXPOSE 8080
