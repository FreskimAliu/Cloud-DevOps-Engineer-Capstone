pipeline {
  agent any

  environment {
    DOCKER_IMAGE = 'udacity-capstone-project'
  }  
  
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
                echo "Build docker image"
                docker build --tag=${DOCKER_IMAGE} .
              '''
            }
    }
    
    stage('Test Docker Container') {
            steps {
              sh '''
                echo "Running docker container"
                docker image ls
                docker run -p 8080:80 ${DOCKER_IMAGE}
                
                echo "Testing docker container"
                if curl -s "http://localhost:8080" | grep "Hello World"
                then
                  echo "Container is working correctly"
                else
                  exit 1
                fi
                
                docker stop $(docker ps -q)
                docker rm $(docker ps -q)
                docker ps 
                
              '''
            }
    }
  }
}