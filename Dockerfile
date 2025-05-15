FROM openjdk:8-jdk-alpine

WORKDIR /app

# Salin kedua JAR
COPY bookingms/target/bookingms-1.0.jar bookingms.jar
COPY routingms/target/routingms-1.0.jar routingms.jar

# Salin skrip helper
COPY wait-for-it.sh wait-for-it.sh
COPY start.sh start.sh

# Install bash, beri izin eksekusi
RUN apk add --no-cache bash \
 && chmod +x wait-for-it.sh start.sh

ENTRYPOINT ["./start.sh"]
