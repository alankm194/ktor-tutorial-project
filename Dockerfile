FROM gradle:4.7.0-jdk8-alpine AS build
WORKDIR /home/gradle/src
COPY --chown=gradle:gradle . .
RUN ls
USER root
RUN gradle build --no-daemon

 
FROM openjdk:8-jre-slim

EXPOSE 80
RUN mkdir app
COPY --from=build /home/gradle/src/build/libs/my-application.jar /app/
ENTRYPOINT java -jar /app/my-application.jar
