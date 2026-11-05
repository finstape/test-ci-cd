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
                    def img = docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}")
                    img.build("-f Dockerfile .")
                    docker.tag(img.id, "${DOCKER_IMAGE}:latest")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
                        def img = docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}")
                        img.push()
                        img.push('latest')
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
