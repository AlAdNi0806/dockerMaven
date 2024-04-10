# Use the official Maven image as the base image
FROM maven:3.8.1-openjdk-11-slim AS build

# Set the working directory
WORKDIR /app

# Copy the pom.xml file and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the rest of the project files
COPY src ./src

# Build the project
RUN mvn package

# Use the Tomcat image to serve the web application
FROM tomcat:9.0-jdk11-openjdk-slim

# Copy the built web application from the build stage
COPY --from=build /app/target/maven-hello-world-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
