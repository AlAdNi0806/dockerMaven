FROM maven:3.6.0-jdk-8

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:resolve


RUN mvn clean package

CMD ["java", "-jar", "target/your-app.jar"]
