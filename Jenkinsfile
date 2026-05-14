pipeline {
    agent any
    
    tools {
        nodejs 'nodejs23'
    }
    
    environment {
        SCANNER_HOME = tool 'sonar-scanner'
        BUILD_NUMBER = "${env.BUILD_NUMBER ?: 'latest'}"
    }

    stages {
        stage('SCM Checkout') {
            steps {
                git branch: 'local-dev', changelog: false, poll: false, url: 'https://github.com/andrewferdinandus/3-Tier-DevSecOps-Project.git'
            }
        }
        
        stage('Frontend Compilation') {
            steps {
                dir('client') {
                    sh 'find . -name "*.js" -exec node --check {} +'
                }
            }
        }
        
        stage('Backend Compilation') {
            steps {
                dir('api') {
                    sh 'find . -name "*.js" -exec node --check {} +'
                }
            }
        }
        
        stage('Gitleaks Scan') {
            steps {
                sh 'gitleaks detect --source ./client --exit-code 1'
                sh 'gitleaks detect --source ./api --exit-code 1'
            }
        }
        
        stage('Sonarqube Analysis') {
            steps {
                withSonarQubeEnv('sonar-server') {
                    sh "${SCANNER_HOME}/bin/sonar-scanner -Dsonar.projectName=NodeJS-Project -Dsonar.projectKey=NodeJS-Project"
                }
            }
        }
        
        stage('Quality Gate Check') {
            steps {
                timeout(time: 10, unit: 'MINUTES') { 
                    waitForQualityGate abortPipeline: true 
                }
            }
        }
        
        stage('Trivy FS Scan') {
            steps {
                sh 'trivy fs --format table -o trivy-fs-report.html .'
            }
        }
        
        stage('Docker build and Push Backend') {
            steps {
                script {
                    def imageName = "andrewferdi/backend-latest"
                    def buildTag = "${imageName}:${env.BUILD_NUMBER}"
                    def latestTag = "${imageName}:latest"
                    
                    withDockerRegistry(credentialsId: 'docker-creds') {
                        dir('api') {
                            sh "docker build -t ${buildTag} -t ${latestTag} ."
                            sh "trivy image --format table -o backend-image-report.html ${buildTag}"
                            sh "docker push ${buildTag}"
                            sh "docker push ${latestTag}"
                        }
                    }
                }
            }
        }

        stage('Docker build and Push Frontend') {
            steps {
                script {
                    def imageName = "andrewferdi/frontend-latest"
                    def buildTag = "${imageName}:${env.BUILD_NUMBER}"
                    def latestTag = "${imageName}:latest"
                    
                    withDockerRegistry(credentialsId: 'docker-creds') {
                        dir('client') {
                            sh "docker build -t ${buildTag} -t ${latestTag} ."
                            sh "trivy image --format table -o frontend-image-report.html ${buildTag}"
                            sh "docker push ${buildTag}"
                            sh "docker push ${latestTag}"
                        }
                    }
                }
            }
        }
        
        stage('Deploy to Local Test') {
            steps {
                withCredentials([file(credentialsId: 'frontend-backend-env', variable: 'SECURE_ENV')]) {
                    script {
                        // 1. Copy your secret credentials into place
                        sh "cp ${SECURE_ENV} .env"
                        
                        // 2. Wipe old containers and data storage
                        sh "docker-compose down -v"
                        
                        // 3. Run compose while explicitly passing the variable forward
                        sh "BUILD_NUMBER=${BUILD_NUMBER} docker-compose up -d"
                    }
                }
            }
        }
    }
}
