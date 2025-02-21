pipeline {
    agent any

    environment {
        IMAGE_NAME = "nextjs-app"
        CONTAINER_NAME = "nextjs-container"
    }

    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()  // Clean the workspace
                sh 'rm -rf .git'  // Remove any existing .git directory
            }
        }
        
        stage('Check Tools') {
            steps {
                sh '''
                    git --version
                    docker --version
                '''
            }
        }

        stage('Clone Repo') {
            steps {
                dir("${env.WORKSPACE}") {
                    sh 'pwd'  // Print the current working directory
                    git branch: 'master',
                        url: 'https://github.com/sayfatay/poc-next-jenkins.git',
                        changelog: false,
                        poll: false
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                dir("${env.WORKSPACE}") {
                    sh "docker build -t $IMAGE_NAME ."
                }
            }
        }
    }

    post {
        always {
            cleanWs()  // Clean the workspace after the build
        }
    }
}