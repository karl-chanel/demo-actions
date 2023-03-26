FROM maven:latest AS builder
WORKDIR /workspace
COPY . /workspace
RUN mvn clean package -Dmaven.test.skip=true

FROM  openjdk:17-alpine
WORKDIR /workspace
COPY --from=builder /workspace/target/*.jar /workspace/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","-Xms64m","-Xmx128m","/workspace/app.jar"]
