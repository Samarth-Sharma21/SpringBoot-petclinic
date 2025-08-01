## Stage1 creating a jar file 

FROM maven:3.9.10-eclipse-temurin-17 AS builder
WORKDIR /app
COPY . .
RUN mvn package -DskipTests

## Stage2 deploying the jar file
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8081
ENTRYPOINT [ "java","-jar","app.jar" ]