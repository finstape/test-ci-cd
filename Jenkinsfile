pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "finstape/test-ci-cd"
        DOCKER_TAG = "${env.BUILD_ID}"
        DOCKERHUB_CREDENTIALS = 'dockerhub-credentials'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def hasDocker = sh script: 'command -v docker', returnStatus: true
                    if (hasDocker == 0) {
                        sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} -t ${DOCKER_IMAGE}:latest ."
                    } else {
                        echo "Docker CLI not found — simulating build: docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG}"
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    def hasDocker = sh script: 'command -v docker', returnStatus: true
                    if (hasDocker == 0) {
                        dockerLogin = dockerLogin(
                            registry: 'https://index.docker.io/v1/',
                            credentialsId: DOCKERHUB_CREDENTIALS
                        )
                        sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                        sh "docker push ${DOCKER_IMAGE}:latest"
                    } else {
                        echo "Docker CLI not found — simulating push to Docker Hub"
                    }
                }
            }
        }
    }

    post {
        always {
            echo "CI/CD pipeline completed"
        }
    }
}
