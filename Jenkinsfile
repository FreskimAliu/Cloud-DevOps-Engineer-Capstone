pipeline {
  agent any
  environment {
    AWS_ACCOUNT_ID="133860621760"
    AWS_DEFAULT_REGION="us-west-2"
    DOCKER_IMAGE="udacity-capstone-project"
    TAG="latest"
    REPOSITORY_URI="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${DOCKER_IMAGE}:${TAG}"
  }
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
        sh 'sudo iptables -I INPUT -m conntrack --ctstate INVALID -j DROP'
        sh 'docker build --tag=${DOCKER_IMAGE} .'
      }
    }

    stage('Test Docker Container') {
      steps {
        sh 'docker run -p 8000:8000 -d ${DOCKER_IMAGE}'
        sh 'docker logs $(docker ps -q)'
        sh 'curl "http://localhost:8000"'
        sh 'docker stop $(docker ps -q)'
        sh 'docker rm $(docker ps -q -a)'
        sh 'docker ps'
      }
    }
    
    stage('Push Image to ECR') {
      steps {
        sh 'aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com'
        sh 'docker tag ${DOCKER_IMAGE}:${TAG} ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${DOCKER_IMAGE}:${TAG}'
        sh 'docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${DOCKER_IMAGE}:${TAG}'
      }
    }
    
    stage('Deploy to EKS') {
      steps {
        withAWS(credentials: 'aws_credentials', region: "${AWS_DEFAULT_REGION}") {
          
          sh 'aws eks update-kubeconfig --name test-cluster'
          sh 'kubectl config use-context arn:aws:eks:us-west-2:133860621760:cluster/test-cluster'
          sh 'kubectl get nodes'
          sh 'kubectl apply -f deploy-k8s.yml'
          sh 'kubectl rollout restart deployments/udacity-capstone-project'
          sh 'kubectl get pod -o wide'
          sh 'kubectl get service/udacity-capstone-project'
        }
      }
    }
    stage ('Validate Deployment') {
      steps {
        withAWS(credentials: 'aws_credentials', region: "${AWS_DEFAULT_REGION}") {
          sh '''
          CLUSTER_ENDPOINT=$(kubectl get svc udacity-capstone-project -o json | jq .status.loadBalancer.ingress[].hostname)
          curl $CLUSTER_ENDPOINT
          '''
        }
      }
    }
    
    stage ('Check Rollout') {
      steps {
        withAWS(credentials: 'aws_credentials', region: "${AWS_DEFAULT_REGION}") {
          sh 'kubectl rollout status deployments/udacity-capstone-project'
        }
      }
    }
  }
}