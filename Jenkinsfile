pipeline {
  agent any
  stages {
    stage('Lint Application') {
      steps {
        sh 'npm install'
        sh 'npm run lint'
        sh 'hadolint Dockerfile'
      }
    }

    stage('Test Application') {
      steps {
        sh 'npm run test'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build --tag=${DOCKER_IMAGE} .'
      }
    }

    stage('Test Docker Container') {
      steps {
        sh 'docker run -p 80:8000 -d ${DOCKER_IMAGE}'
        sh 'docker logs $(docker ps -q)'
        sh 'curl "http://localhost:80"'
        sh 'docker stop $(docker ps -q)'
        sh 'docker rm $(docker ps -q -a)'
        sh 'docker ps'
      }
    }

  }
  environment {
    DOCKER_IMAGE = 'udacity-capstone-project'
  }
}
