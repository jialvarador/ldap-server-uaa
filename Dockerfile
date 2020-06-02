# syntax=docker/dockerfile:experimental

########Maven build stage########
FROM maven:3.5-alpine AS MAVEN_BUILD
MAINTAINER Jose Inocencio Alvarado
#copy pom
COPY pom.xml /build/
COPY src/ /build/src/
WORKDIR /build/
RUN mvn  dependency:resolve
# build the app (no dependency download here)
RUN mvn  package

FROM openjdk:8-alpine
WORKDIR /app

COPY --from=MAVEN_BUILD build/target/ldapserver-uaa-1.0.0.BUILD-SNAPSHOT.jar /app/
CMD ["java", "-jar", "ldapserver-uaa-1.0.0.BUILD-SNAPSHOT.jar"]
