pipeline {
    agent any
    tools {
        maven 'MavenV_3.9.6'
    }
    stages {
        stage('Build Maven') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/NGHardik/testProject']]])
                sh 'mvn clean install'
            }
        }

        stage('Build docker image') {
            steps {
                script {
                    sh 'docker build -t nghardik/testproject .'
                }
            }
        }

        stage('Push image to Hub') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'docker', variable: 'docker')]) {
                        sh 'docker login -u nghardik -p ${docker}'
                    }
                    sh 'docker push nghardik/testproject'
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withCredentials([string(credentialsId: 'sonarqubeToken', variable: 'SONAR_TOKEN')]) {
                    sh "mvn sonar:sonar -Dsonar.projectKey=tasklast -Dsonar.host.url=http://localhost:9000 -Dsonar.login=${env.SONAR_TOKEN}"
                }
            }
        }

       
		
		 stage('Run Docker container on Jenkins Agent') {
             
            steps {
                sh "docker run -d -p 4030:8080 nghardik/testproject"
 
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
