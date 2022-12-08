pipeline{
    agent any
	tools {
      maven 'M2_HOME'
    }
    stages{
        stage("Git Checkout"){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/pramodmadhavanvc1/jenkins-docker-example.git']]])
            }
        }
        stage("Maven Package"){
            steps{
                sh "mvn clean package"
            }
        }
        stage("Docker Build"){
            steps{
                sh "docker build . -t pramodmadhavan/nodejsapp-1.0:latest "
            }
        }
        stage("DockerHub Push"){
            steps{
                withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
                    sh "docker login -u pramodmadhavan -p ${dockerHubPwd}"
                    sh "docker push pramodmadhavan/nodejsapp-1.0:latest "
                }
                
            }
        }
        stage("Docker Deploy worker"){
            steps{
                sshagent(['worker-server']) {
                    sh "ssh -o StrictHostKeyChecking=no origin@10.0.2.7 docker rm -f pramodapp"
                    sh "ssh origin@10.0.2.7 docker run -d -p 31315:80 --name pramodapp pramodmadhavan/nodejsapp-1.0:latest"
                }
                
            }
        }
    }
}
