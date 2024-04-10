# Используйте Maven для сборки зависимостей
FROM maven:3.8.1-openjdk-11-slim AS build

# Копируйте только pom.xml для сборки зависимостей
COPY ./pom.xml ./pom.xml

# Скачиваем все зависимости для оффлайн-использования
RUN mvn dependency:go-offline -B

# Выполняем сборку проекта
RUN mvn package

# Используйте базовый образ OpenJDK для запуска приложения
FROM openjdk:11-jre-slim

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем собранный jar файл из предыдущего этапа
COPY --from=build /app/target/my-app-1.0.jar /app/my-app.jar

# Запускаем приложение
CMD ["java", "-jar", "/app/my-app.jar"]
