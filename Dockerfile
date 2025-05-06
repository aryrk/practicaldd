# Build stage
FROM maven:3.8.6-openjdk-11 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# BookingMS stage
FROM openjdk:11-jre-slim AS bookingms
COPY --from=builder /app/bookingms/target/*.jar /app.jar
ENTRYPOINT ["java","-jar","/app.jar"]

# HandlingMS stage
FROM openjdk:11-jre-slim AS handlingms
COPY --from=builder /app/handlingms/target/*.jar /app.jar
ENTRYPOINT ["java","-jar","/app.jar"]

# RoutingMS stage
FROM openjdk:11-jre-slim AS routingms
COPY --from=builder /app/routingms/target/*.jar /app.jar
ENTRYPOINT ["java","-jar","/app.jar"]

# TrackingMS stage
FROM openjdk:11-jre-slim AS trackingms
COPY --from=builder /app/trackingms/target/*.jar /app.jar
ENTRYPOINT ["java","-jar","/app.jar"]