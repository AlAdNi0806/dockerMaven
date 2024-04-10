# Stage 1: Use Maven to create a basic project structure
FROM maven:3.8.1-openjdk-11 as builder
WORKDIR /app
RUN mvn archetype:generate -DgroupId=com.example -DartifactId=my-web-app -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false

# Stage 2: Build the application using Maven
FROM maven:3.8.1-openjdk-11 as build
WORKDIR /app
COPY --from=builder /app/my-web-app/pom.xml .
COPY --from=builder /app/my-web-app/src ./src
RUN mvn clean package -DskipTests

# Stage 3: Setup Tomcat and deploy the application
FROM tomcat:9.0-jdk11-openjdk-slim
COPY --from=build /app/target/my-web-app.war /usr/local/tomcat/webapps/ROOT.war
