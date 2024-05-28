# Build stage
FROM openjdk:21-slim AS build
ENV HOME=/usr/template-api
RUN mkdir -p $HOME
WORKDIR $HOME
ADD . $HOME
RUN --mount=type=cache,target=/root/.m2 ./mvnw -f $HOME/pom.xml clean package

# Package stage
FROM openjdk:21-slim
COPY --from=BUILD /usr/template-api/target/*.jar /usr/template.jar
EXPOSE 9000
ENTRYPOINT exec java -jar /usr/template.jar