node {
  stage('Maven build') {
    checkout scm
                
    docker.image('maven:3.6.1-jdk-11').inside {
      sh "mvn --version"
      sh "mvn package"
      junit 'target/surefire-reports/*.xml'
      cobertura coberturaReportFile: 'target/site/cobertura/coverage.xml'
    }
  }
  
  /*
  stage('SonarQube') {
    def scannerHome = tool 'scanner';
   
    withSonarQubeEnv('SonarQube') {
      sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=java-microservice-jetty -Dsonar.sources=. -Dsonar.java.binaries=./target/classes"
    }
  }
*/
  stage ('Docker Build') {
    sh "docker build -t java-microservice-jetty:1 ."
  }
  
  stage ('Push') {
    sh "git rev-parse --short HEAD > commit-id"
    tag = readFile('commit-id').replace("\n", "").replace("\r", "")
    appname = "java-microservice-jetty:"
    registryHost = "127.0.0.1:30400/"
    imageName = "${registryHost}${appname}${tag}"
    sh "docker tag java-microservice-jetty:1 ${imageName}"
    sh "docker push ${imageName}"
  }
  
  stage ('Deploy') {
    sh "git rev-parse --short HEAD > commit-id"
    tag = readFile('commit-id').replace("\n", "").replace("\r", "")
    sh "sed 's#127.0.0.1:30400/java-microservice-jetty:version#127.0.0.1:30400/java-microservice-jetty:'$tag'#' deployment.yml | kubectl apply -f -"
  }
}
