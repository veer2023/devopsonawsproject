# Use official Maven image to build the project
FROM maven:3.8.7-eclipse-temurin-17 AS build

# Set working directory inside container
WORKDIR /app

# Copy pom.xml and download dependencies
COPY pom.xml .

RUN mvn dependency:go-offline -B

# Copy source code
COPY src ./src

# Build the project (skip tests for speed)
RUN mvn clean package -DskipTests

# Use a lightweight OpenJDK runtime image
FROM eclipse-temurin:17-jre-alpine

# Copy the jar from the build stage
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar /app/demo.jar

# Expose port 8080
EXPOSE 8080

# Run the jar file
ENTRYPOINT ["java","-jar","/app/demo.jar"]
