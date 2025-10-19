# Multi-stage build for Spring Boot
FROM gradle:7.6-jdk17 AS build

WORKDIR /app

# Copy gradle wrapper and build files
COPY gradlew .
COPY gradle gradle
COPY build.gradle settings.gradle ./

# Download dependencies (cached layer)
RUN ./gradlew dependencies --no-daemon || return 0

# Copy source code
COPY src ./src

# Build the application
RUN ./gradlew clean bootJar --no-daemon

# Runtime stage with JDK 17
FROM eclipse-temurin:17-jre-jammy

LABEL maintainer="ajitata6f@gmail.com"
LABEL version="1.0"
LABEL description="Spring Boot Application with JDK 17"

WORKDIR /app

# Install dependencies
#RUN apk update && apk add --no-cache wget

# Create non-root user for security
RUN groupadd -r spring && useradd -r -g spring spring

# Copy the built jar from build stage
COPY --from=build /app/build/libs/*.jar app.jar

# Change ownership to non-root user
RUN chown -R spring:spring /app

# Switch to non-root user
USER spring

# Expose application port
EXPOSE 8080

# Health check for Spring Boot Actuator
HEALTHCHECK --interval=30s --timeout=3s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:8080/actuator/health || exit 1

# Run the Spring Boot application
ENTRYPOINT ["java", \
    "-Djava.security.egd=file:/dev/./urandom", \
    "-Xms512m", \
    "-Xmx1024m", \
    "-XX:+UseParallelGC", \
    "-XX:MaxMetaspaceSize=256m", \
    "-jar", \
    "/app/app.jar"]