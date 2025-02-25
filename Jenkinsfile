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

        // stage('Clone Repo') {
        //     steps {
        //         dir("${env.WORKSPACE}") {
        //             sh 'pwd'  // Print the current working directory
        //             git branch: 'master',
        //                 url: 'https://github.com/sayfatay/poc-next-jenkins.git',
        //                 changelog: false,
        //                 poll: false
        //         }
        //     }
        // }

        stage('Clone or Pull Repo') {
            steps {
                dir("${env.WORKSPACE}") {
                    script {
                        if (fileExists(".git")) {
                            sh '''
                                echo "Repository already exists. Pulling latest changes..."
                                git reset --hard
                                git pull origin master
                            '''
                        } else {
                            echo "Cloning repository..."
                            sh '''
                                git clone -b master git@github.com:sayfatay/poc-next-jenkins.git .
                            '''
                        }
                    }
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

        stage('Stop & Remove Old Container') {
            steps {
                script {
                    sh """
                        docker stop $CONTAINER_NAME || true
                        docker rm $CONTAINER_NAME || true
                    """
                }
            }
        }

        stage('Run New Container') {
            steps {
                script {
                    sh "docker run -d --name $CONTAINER_NAME -p 8077:3000 $IMAGE_NAME"
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