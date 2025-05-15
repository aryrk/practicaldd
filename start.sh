#!/usr/bin/env bash
set -e

# Tunggu semua service siap
./wait-for-it.sh mysql_booking:3306 --timeout=60 --strict -- echo "MySQL Booking siap"
./wait-for-it.sh mysql_routing:3306 --timeout=60 --strict -- echo "MySQL Routing siap"
./wait-for-it.sh axonserver:8124 --timeout=60 --strict -- echo "AxonServer siap"

# Jalankan kedua aplikasi bersamaan
java -jar bookingms.jar \
     --spring.datasource.url=${BOOKING_DATASOURCE_URL} \
     --spring.datasource.username=${BOOKING_DATASOURCE_USERNAME} \
     --spring.datasource.password=${BOOKING_DATASOURCE_PASSWORD} \
     --axon.axonserver.servers=${AXON_AXONSERVER_SERVERS} \
     --spring.jpa.database-platform=${SPRING_JPA_DATABASE_PLATFORM} \
     --spring.jpa.generate-ddl=${SPRING_JPA_GENERATE_DDL} &

java -jar routingms.jar \
     --spring.datasource.url=${ROUTING_DATASOURCE_URL} \
     --spring.datasource.username=${ROUTING_DATASOURCE_USERNAME} \
     --spring.datasource.password=${ROUTING_DATASOURCE_PASSWORD} \
     --spring.jpa.database-platform=${ROUTING_JPA_DATABASE_PLATFORM} \
     --spring.jpa.generate-ddl=${ROUTING_JPA_GENERATE_DDL}

# Menunggu jika perlu (opsional)
wait
