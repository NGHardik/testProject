FROM openjdk:17-oracle
EXPOSE 7171
ADD target/testProject-0.0.1-SNAPSHOT.jar testProject.jar
ENTRYPOINT ["java", "-jar", "/testProject.jar"]
