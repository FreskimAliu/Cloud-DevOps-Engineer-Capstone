pipeline {
  agent any
  stages {
    stage('Lint Application') {
            steps {
              sh '''
                echo "Installing node dependecies"
                npm install
                
                echo "Linting JavaScript code"
                npm run lint
                
                echo "Linting Docker file"
                hadolint Dockerfile
              '''
            }
    }
    
    stage('Test Application') {
            steps {
              sh '''
                echo "Testing application"
                npm run test
              '''
            }
    }
    
    stage('Build Docker Image') {
            steps {
              sh '''
                echo "Building docker image"
                ./run_docker.sh
              '''
            }
    }
    

  }
}