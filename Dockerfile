FROM maven:3.8.3-openjdk-17 AS Build
RUN git clone https://github.com/SreekakulapuBharatkumar/java-project.git
WORKDIR java-project
RUN mvn package


FROM openjdk:17-alpine
LABEL author="Bharat"
WORKDIR /tmp/
COPY --from=Build java-project/target/ /tmp/
EXPOSE 8080
CMD ["java","-jar","spring-petclinic-3.1.0-SNAPSHOT.jar"]