# Étape 1 : compilation avec Maven
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn package -DskipTests -B

# Étape 2 : image d'exécution légère
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/democyber-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
