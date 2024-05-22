FROM openjdk:17-oracle
EXPOSE 7171
ADD target/testProject.jar testProject.jar
ENTRYPOINT ["java", "-jar", "/testProject.jar"]
