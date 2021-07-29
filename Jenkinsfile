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

  }
}