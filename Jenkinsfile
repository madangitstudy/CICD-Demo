pipeline {
    agent any

    environment {
        SONARQUBE_SERVER = 'sonarqube' // SonarQube server name configured in Jenkins
        DOCKER_IMAGE = 'my-java-app:latest'
        KUBERNETES_NAMESPACE = 'java-app'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/madangitstudy/CICD-Demo.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Code Analysis') {
            steps {
                withSonarQubeEnv(SONARQUBE_SERVER) {
                    sh 'mvn sonar:sonar'
                }
            }
        }

        stage('Docker Build and Push') {
            steps {
                sh '''
                docker build -t madanbokare/$DOCKER_IMAGE .
                docker push madanbokare/$DOCKER_IMAGE
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                helm upgrade --install my-java-app ./helm-chart \
                    --namespace $KUBERNETES_NAMESPACE \
                    --set image.repository=madanbokare/$DOCKER_IMAGE
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline execution failed!'
        }
    }
}

