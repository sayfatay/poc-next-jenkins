pipeline {
    agent any

    environment {
        IMAGE_NAME = "nextjs-app"
        CONTAINER_NAME = "nextjs-container"
    }

    stages {
        
        stage('Check Git Version') {
            steps {
                script {
                    sh 'git --version'
                }
            }
        }
        stage('Clone Repo') {
            steps {
                git url: 'https://github.com/sayfatay/poc-next-jenkins.git', branch: 'master'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t $IMAGE_NAME ."
                }
            }
        }
        
        // stage('Stop & Remove Old Container') {
        //     steps {
        //         script {
        //             sh """
        //                 docker stop $CONTAINER_NAME || true
        //                 docker rm $CONTAINER_NAME || true
        //             """
        //         }
        //     }
        // }
        
        // stage('Run New Container') {
        //     steps {
        //         script {
        //             sh "docker run -d --name $CONTAINER_NAME -p 80:80 $IMAGE_NAME"
        //         }
        //     }
        // }
    }
}
