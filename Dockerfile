# Stage 1: Build the application using Maven
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Run the built JAR
FROM openjdk:17
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
# Stage 3: Run the application with a specific profile
# Uncomment the following line to run with a specific profile, e.g., "prod"
# CMD ["java", "-jar", "app.jar", "--spring.profiles.active=prod"]