pipeline {
    agent any

    environment {
        DEV_IMAGE  = 'roshanvs1/dev'
        PROD_IMAGE = 'roshanvs1/prod'
        TAG        = "${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Docker Login') {
            steps {
                sh '''
                  echo "$DOCKERHUB_CREDENTIALS_PSW" | \
                  docker login -u "$DOCKERHUB_CREDENTIALS_USR" --password-stdin
                '''
            }
        }

        stage('Build & Push Image') {
            steps {
                script {
                    sh 'chmod +x build.sh'
                    sh './build.sh'
                    
                }
            }
        }

        stage('Deploy') {
            steps {
                sh './deploy.sh'
            }
        }
    }
}









