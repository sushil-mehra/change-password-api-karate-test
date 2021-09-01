# Start with a base image containing Java runtime
FROM openjdk:8-jdk-alpine

# Add a volume pointing to /tmp
VOLUME /tmp

# Make port 8080 available to the world outside this container
EXPOSE 8081

# The application's jar file
ARG JAR_FILE=target/change-password-api-karate-tests-1.0.0-SNAPSHOT.jar

# Add the application's jar to the container
ADD ${JAR_FILE} change-password-api-karate-tests.jar

# Run the jar file
ENTRYPOINT ["java","-jar","/change-password-api-karate-tests.jar"]
