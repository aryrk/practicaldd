FROM openjdk:8-jdk-alpine

WORKDIR /app

COPY target/trackingms-1.0.jar trackingms-1.0.jar
COPY wait-for-it.sh wait-for-it.sh

RUN apk add --no-cache bash \
 && chmod +x wait-for-it.sh

ENTRYPOINT ["./wait-for-it.sh", "mysql:3306", "--", "java", "-jar", "trackingms-1.0.jar"]
