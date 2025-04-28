pipeline {
    agent any

    environment { 
        IMAGE_NAME = 'shifter1703/test' 
        CONTAINER_NAME = 'test' 
        REPO_URL = 'https://github.com/NikDokin/Tester' 
        DOCKER_HUB_REPO = 'shifter1703/test' 
        DOCKER_CREDENTIALS_ID = 'ce217c82-26b0-4acb-b57f-71a11965e25d'  // Убедитесь, что credentials существует
    }

    stages { 
        stage('Checkout') {
            steps {
                script {
                    // Извлекаем репозиторий и определяем тег
                    git branch: 'master', url: env.REPO_URL 
                }
            }
        }

        stage('Stop and remove container') {
            steps {
                script {
                    // Попытка удалить контейнер, если он существует
                    sh "docker rm -f ${env.CONTAINER_NAME} || true"
                }
            }
        }

        stage('Pull Docker Image') {
            steps {
                script {
                    // Используем Jenkins Credentials для безопасного логина
                    withCredentials([usernamePassword(credentialsId: env.DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh """
                            docker login -u \${DOCKER_USERNAME} -p \${DOCKER_PASSWORD}
                            docker pull ${env.IMAGE_NAME}:${env.IMAGE_TAG}
                            docker pull ${env.IMAGE_NAME}:latest
                        """
                    }
                }
            }
        }

        stage('Start container') {
            steps {
                script {
                    // Запуск контейнера с нужным образом
                    sh "docker run -d --name ${env.CONTAINER_NAME} ${env.IMAGE_NAME}:${env.IMAGE_TAG}" 
                }
            }
        }
    }

    post { 
        success {
            echo "The pipeline has been completed successfully!" 
        }
        failure {
            echo "The pipeline ended with an error. Check the logs for details."
        }
        always {
            echo "Pipeline completion completed" 
            cleanWs() 
        }
    }
}
