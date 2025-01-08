# Use the official OpenJDK image as a base
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the target folder to the container
COPY target/my-java-app.jar /app/my-java-app.jar

# Define the command to run the JAR file
ENTRYPOINT ["java", "-jar", "/app/my-java-app.jar"]
