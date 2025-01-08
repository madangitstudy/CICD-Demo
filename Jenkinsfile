pipeline {
    agent any

    environment {
        SONARQUBE_SERVER = 'sonarqube' // SonarQube server name configured in Jenkins
        SONARQUBE_URL = 'http://3.6.93.45:9000' // Replace with your actual SonarQube server URL
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
                
                // Debugging: List files in target folder to ensure the JAR file is created
                sh 'ls -R target/'

                // Verify that the JAR file is present before proceeding
                script {
                    if (!fileExists('target/my-java-app.jar')) {
                        error 'JAR file not found in target directory!'
                    }
                }
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
                script {
                    // Docker login to Docker Hub
                    docker.withRegistry('https://index.docker.io/v1/', 'docker') {
                        // Build and push the Docker image
                        sh 'docker build -t madanbokare/$DOCKER_IMAGE .'
                        sh 'docker push madanbokare/$DOCKER_IMAGE'
                    }
                }
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
