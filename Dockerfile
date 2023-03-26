FROM maven:latest AS builder
WORKDIR /workspace
COPY . /workspace
RUN mvn clean package -Dmaven.test.skip=true

FROM mintya/jre17-alpine
WORKDIR /workspace
COPY --from=builder /workspace/target/*.jar /workspace/app.jar
ENTRYPOINT ["java","-jar","-Xms64m","-Xmx128m","/workspace/app.jar"]
