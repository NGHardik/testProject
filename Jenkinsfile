pipeline {
    agent any
    environment {
        MAVEN_HOME = tool name: 'MavenV_3.9.6', type: 'maven'
        GIT_REPO = 'https://github.com/NGHardik/testProject'
        SONAR_TOKEN = credentials('sonarqubeToken')
        DOCKER_HUB_CREDENTIALS = credentials('docker')
    }

    stages {
        stage('Checkout') {
            steps {
                git url: "${env.GIT_REPO}", branch: 'master'
            }
        }

        stage('Build and Test with Maven') {
            steps {
                script {
                    withMaven(maven: 'MavenV_3.9.6') {
                        sh 'mvn clean install'
                    }
                }
            }
        }
        stage('SonarQube Analysis') {
            steps {
                script {
                    withMaven(maven: 'MavenV_3.9.6') {
                        sh "mvn sonar:sonar -Dsonar.projectKey=your_project_key -Dsonar.host.url=http://localhost:9000 -Dsonar.login=${env.SONAR_TOKEN}"
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t nghardik/testproject .'
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockerhub', variable: 'dockerhub')]) {
                        sh "docker login -u nghardik -p ${dockerhub}"
                    }
                    sh "docker push nghardik/testproject"
                }
            }
        }

        

        stage('Run Docker Container on Jenkins Agent') {
            steps {
                script {
                    sh "docker run -d -p 4030:8088 nghardik/testproject"
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}

