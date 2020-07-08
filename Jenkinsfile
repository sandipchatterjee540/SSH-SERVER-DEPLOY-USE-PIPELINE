pipeline{
    def remote = [:]
    remote.name = 'test'
    remote.host = 'ssh-server'
    remote.user = 'root'
    remote.password = 'sandip'
    remote.allowAnyHosts = true
    

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
    
    stage('Remote SSH') {
      sshCommand remote: remote, command: "./tmp/put_db.sh"
    }
       
}
}



































