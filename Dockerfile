# Use Maven to build the application
FROM maven:3.8.6-openjdk-18-slim AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline

# Run the application
FROM openjdk:18-slim
WORKDIR /app
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
