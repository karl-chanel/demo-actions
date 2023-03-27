FROM maven:latest AS builder
WORKDIR /app
COPY . /app
RUN mvn clean package -Dmaven.test.skip=true

FROM  openjdk:17-alpine
WORKDIR /app
COPY --from=builder /app/target/*.jar /app/app.jar
ENV JAVA_OPTS="\
-server \
-Xms128 \
-Xmx256 \
-XX:MetaspaceSize=128m \
-XX:MaxMetaspaceSize=256m"
EXPOSE 8080
ENTRYPOINT java ${JAVA_OPTS} -jar  /app/app.jar
