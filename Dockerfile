# multi-stage build
FROM maven:3.8.7-eclipse-temurin-17 AS builder
WORKDIR /workspace
COPY pom.xml .
COPY src ./src
# build a fat jar (adjust maven flags to your project)
RUN mvn -B -DskipTests package

FROM eclipse-temurin:17-jre
ARG JAR_FILE=target/*.jar
COPY --from=builder /workspace/${JAR_FILE} /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
