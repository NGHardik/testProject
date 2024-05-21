FROM openjdk:8
EXPOSE 7171
ADD target/testProject.jar testProject.jar
ENTRYPOINT ["java","-jar","/testProject.jar"]