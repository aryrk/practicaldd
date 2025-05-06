# Dockerfile
FROM openjdk:8-jdk-alpine

WORKDIR /app

# Copy jar hasil build dan skrip wait-for-it
ARG JAR_FILE=target/bookingms-1.0.jar
COPY ${JAR_FILE} app.jar
COPY wait-for-it.sh wait-for-it.sh

# Install bash karena skrip wait-for-it.sh menggunakan bash
RUN apk add --no-cache bash \
 && chmod +x wait-for-it.sh

# Tunggu MySQL dan AxonServer siap, lalu jalankan Spring Boot
ENTRYPOINT ["./wait-for-it.sh", "mysql:3306", "--", \
            "./wait-for-it.sh", "axonserver:8124", "--", \
            "java", "-jar", "app.jar"]