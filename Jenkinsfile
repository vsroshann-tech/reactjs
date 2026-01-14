pipeline {
    agent any

    environment {
        
        DEV_IMAGE  = 'roshanvs1/dev'
        PROD_IMAGE = 'roshanvs1/prod'
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
                    
                    if (env.GIT_BRANCH == 'dev') {
                        sh """
                          docker build -t $DEV_IMAGE:$tag .
                          docker tag $DEV_IMAGE:$tag $DEV_IMAGE:latest
                          docker push $DEV_IMAGE:$tag
                          docker push $DEV_IMAGE:latest
                        """
                    }

                    elif (env.GIT_BRANCH == 'main') {
                        sh """
                          docker build -t $PROD_IMAGE:$tag .
                          docker tag $PROD_IMAGE:$tag $PROD_IMAGE:latest
                          docker push $PROD_IMAGE:$tag
                          docker push $PROD_IMAGE:latest
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
