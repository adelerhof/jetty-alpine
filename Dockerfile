FROM jetty:alpine
COPY ./target/jetty-alpine-1.0-SNAPSHOT.war /var/lib/jetty/webapps/jetty-alpine.war
EXPOSE 8080
