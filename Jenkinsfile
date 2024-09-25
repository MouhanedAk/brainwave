pipeline {
    agent { label 'Jenkins-Agent' }
    tools {
        nodejs 'node19'
    }
    environment {
        APP_NAME = "react-app"
        RELEASE = "1.0.0"
        DOCKER_USER = "mouhanedakermi"
        DOCKER_PASS = 'dockerhub' 
        IMAGE_NAME = "${DOCKER_USER}/${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
    }
    stages {
        stage("Cleanup Workspace") {
            steps {
                cleanWs()
            }
        }

        stage("Checkout from SCM") {
            steps {
                git branch: 'master', credentialsId: 'github', url: 'https://github.com/MouhanedAk/brainwave'
            }
        }

        stage("Install Dependencies") {
            steps {
                script {
                    sh 'npm cahce --clean force'
                    sh 'npm install'
                }
            }
        }

        stage("Build Application") {
            steps {
                script {
                    sh 'CI=false npm run build --verbose'
                }
            }
        }

        stage("Test Application") {
            steps {
                script {
                    sh 'npm test'
                }
            }
        }

        stage("Build & Push Docker Image") {
            steps {
                script {
                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image = docker.build "${IMAGE_NAME}"
                    }

                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push('latest')
                    }
                }
            }

       }
    }

    post {
        always {
            cleanWs()
        }
    }
}
