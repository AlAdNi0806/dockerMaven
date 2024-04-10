# Используйте официальный образ Maven
FROM maven:3.8.1-openjdk-11-slim AS build

# Установите необходимые пакеты
RUN apt-get update && apt-get install -y \
    && rm -rf /var/lib/apt/lists/*

# Установите рабочую директорию в контейнере
WORKDIR /app

# Копируйте исходный код приложения в контейнер
COPY src /app/src
COPY pom.xml /app

# Выполните сборку приложения с помощью Maven
RUN mvn clean package

# Создайте новый образ для запуска приложения
FROM openjdk:11-jre-slim

# Установите рабочую директорию в контейнере
WORKDIR /app

# Копируйте собранный jar файл в новый образ
COPY --from=build /app/target/my-app-1.0.jar /app/my-app.jar

# Запустите приложение
CMD ["java", "-jar", "/app/my-app.jar"]
