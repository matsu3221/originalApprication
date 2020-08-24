FROM openjdk:8-jdk-alpine
ARG JAR_FILE=access-data-knowledge/build/libs/access-data-knowledge-0.0.1-SNAPSHOT.jar
ARG MYSQL_HOST="mysql:3306"
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]