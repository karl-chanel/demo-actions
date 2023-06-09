FROM mikevivi/mymaven-3.9.1-17:v1 AS builder
WORKDIR /app
COPY . /app
RUN mvn clean package -Dmaven.test.skip=true

FROM  openjdk:17-slim-bullseye
WORKDIR /appdo
COPY --from=builder /app/target/*.jar /app/app.jar
ENV JAVA_OPTS="\
-Xms128m \
-Xmx256m \
-XX:MetaspaceSize=64m \
-XX:MaxMetaspaceSize=128m"

EXPOSE 8080
ENTRYPOINT java ${JAVA_OPTS} -jar  /app/app.jar
