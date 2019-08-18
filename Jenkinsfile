node {
  stage('Maven build') {
    checkout scm
                
    docker.image('maven:3.6.1-jdk-11').inside {
      sh "mvn --version"
      sh "mvn clean package"
    }
  }
  
  stage('SonarQube') {
    def scannerHome = tool 'scanner';
   
    withSonarQubeEnv('SonarQube') {
      sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=javawebapp -Dsonar.sources=."
    }
  }
  /*
  stage ('Docker Build') {
    sh "docker build -t ${imageName} ."
  }
  
  stage ('Push') {
    sh "docker push ${imageName}"
  }
  stage ('Deploy') {
    sh "sed 's#127.0.0.1:30400/javawebapp:version#127.0.0.1:30400/javawebapp:'$tag'#' deployment.yml | kubectl apply -f -"
  }
  */
}
