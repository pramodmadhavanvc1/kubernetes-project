pipeline{
    agent any
    environment {
      DOCKER_TAG = getVersion()
    }
	    stages{
        stage("Git Checkout"){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/Development']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/pramodmadhavanvc1/kubernetes-project.git']]])
            }
        }
        stage("Docker Build"){
            steps{
                sh "docker build . -t  pramodmadhavan/webapp:${DOCKER_TAG}"
            }
        }
        stage("DockerHub Push"){
            steps{
                withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
                    sh "docker login -u pramodmadhavan -p ${dockerHubPwd}"
                    sh "docker push pramodmadhavan/webapp:${version} "
                }
                
            }
        }
        
        stage("Deploy on K8S"){
            steps{
                
                  sh "version=`cat version |grep version |awk '{print \$2}'`| sed -i "s/{{theversion}}/$version/" resource/webapp.yaml"
                  sh "kubectl apply -f resource/webapp.yaml" 
                        
                 }   
                
            
        }
    }
}
def getVersion(){
    version = sh(returnStdout: true, script: "cat version |grep version |awk '{print \$2}'")
    return version
}
