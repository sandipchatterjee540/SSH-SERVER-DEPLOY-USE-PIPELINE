pipeline{

    environment {
    registry = "192.168.43.26:5000/sandiptest/sshserver"
    dockerImage = ""
  }

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        sh 'echo ${BUILD_NUMBER}'
        git 'https://github.com/sandipchatterjee540/SSH-SERVER-DEPLOY-USE-PIPELINE.git'
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }

    stage('Push Image') {
      steps{
        script {
          docker.withRegistry( "" ) {
            dockerImage.push()
          }
        }
      }
    }

    stage('Deploy App') {
      steps {
        script {
          kubernetesDeploy(configs: "sshapp.yaml", kubeconfigId: "KUBECONFIG")
          kubernetesDeploy(configs: "db_host.yaml", kubeconfigId: "KUBECONFIG")
        }
      }
    }
      
    stage ('Deploy') {
    steps{
        sshagent(credentials : ['SSH-SERVER']) {
            sh 'ssh -o StrictHostKeyChecking=no remote_user@remote_host whoami'
           
        }
    }
}

  }
}



































