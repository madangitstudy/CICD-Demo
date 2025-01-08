FROM openjdk:17-jdk-slim
WORKDIR /app
COPY target/my-java-app.jar /app/
ENTRYPOINT ["java", "-jar", "my-java-app.jar"]

