FROM openjdk:8-jdk-alpine
# RUN addgroup -S camunda && adduser -S camunda -G camunda
# USER camunda:camunda
ARG DEPENDENCY=target/dependency
COPY ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY ${DEPENDENCY}/META-INF /app/META-INF
COPY ${DEPENDENCY}/BOOT-INF/classes /app
ENTRYPOINT ["java","-cp","app:app/lib/*","org.camunda.example.Application"]
EXPOSE 8080