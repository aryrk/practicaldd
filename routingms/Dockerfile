FROM openjdk:8-jdk-alpine
VOLUME /tmp
ARG JAR_FILE=target/routingms-1.0.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
