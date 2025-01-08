FROM openjdk:17-jdk-slim
WORKDIR /app
COPY target/my-java-app.jar /app/my-java-app.jar
ENTRYPOINT ["java", "-jar", "/app/my-java-app.jar"]
