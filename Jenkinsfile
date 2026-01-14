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
                    if (env.GIT_BREANCH == 'dev') {

                        sh """
                          docker build -t ${DEV_IMAGE}:${TAG} .
                          docker tag ${DEV_IMAGE}:${TAG} ${DEV_IMAGE}:latest
                          docker push ${DEV_IMAGE}:${TAG}
                          docker push ${DEV_IMAGE}:latest
                        """

                    } else if (env.GIT_BRANCH == 'main') {

                        sh """
                          docker build -t ${PROD_IMAGE}:${TAG} .
                          docker tag ${PROD_IMAGE}:${TAG} ${PROD_IMAGE}:latest
                          docker push ${PROD_IMAGE}:${TAG}
                          docker push ${PROD_IMAGE}:latest
                        """
                    }
                }
            }
        }

        stage('Deploy') {
            when {
                branch 'dev'
            }
            steps {
                sh './deploy.sh'
            }
        }
    }
}









