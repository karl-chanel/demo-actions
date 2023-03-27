FROM maven:latest AS builder
WORKDIR /app
COPY . /app
RUN mvn clean package -Dmaven.test.skip=true

FROM  openjdk:17-alpine
WORKDIR /app
COPY --from=builder /app/target/*.jar /app/app.jar
ENV JAVA_OPTS="\
-Xms128m \
-Xmx256m \
-XX:MetaspaceSize=64m \
-XX:MaxMetaspaceSize=128m"

EXPOSE 8080
ENTRYPOINT java ${JAVA_OPTS} -jar  /app/app.jar
