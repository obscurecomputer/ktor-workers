FROM gradle:9.2.1-jdk21 AS build

WORKDIR /app

COPY gradle gradle
COPY gradlew .
COPY build.gradle.kts settings.gradle.kts gradle.properties ./

RUN ./gradlew dependencies --no-daemon
COPY src src
RUN ./gradlew shadowJar --no-daemon

FROM eclipse-temurin:8-alpine-3.21
WORKDIR /app

COPY --from=build /app/build/libs/*-all.jar app.jar
EXPOSE 8080

CMD ["java", "-jar", "app.jar"]