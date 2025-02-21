pipeline {
    agent any

    environment {
        IMAGE_NAME = "nextjs-app"
        CONTAINER_NAME = "nextjs-container"
    }

    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()  // ล้าง workspace เก่าก่อน
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
                dir("${env.WORKSPACE}") {  // ระบุ directory ชัดเจน
                    git branch: 'main',
                        url: 'https://github.com/sayfatay/poc-next-jenkins.git',
                        changelog: false,
                        poll: false
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                dir("${env.WORKSPACE}") {  // ต้องแน่ใจว่าอยู่ใน directory ที่มี Dockerfile
                    sh "docker build -t $IMAGE_NAME ."
                }
            }
        }
    }

    post {
        always {
            cleanWs()  // ล้าง workspace หลังเสร็จงาน
        }
    }
}