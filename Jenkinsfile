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
  
  stage('SonarQube') {
    def scannerHome = tool 'scanner';
   
    withSonarQubeEnv('SonarQube') {
      sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=rest-java-jetty -Dsonar.sources=. -Dsonar.java.binaries=./target/classes"
    }
  }

  stage ('Docker Build') {
    sh "docker build -t jetty-alpine:1 ."
  }
  
  stage ('Push') {
    sh "git rev-parse --short HEAD > commit-id"
    tag = readFile('commit-id').replace("\n", "").replace("\r", "")
    appname = "jetty-alpine:"
    registryHost = "127.0.0.1:30400/"
    imageName = "${registryHost}${appname}${tag}"
    sh "docker tag jetty-alpine:1 ${imageName}"
    sh "docker push ${imageName}"
  }
  
  stage ('Deploy') {
    sh "git rev-parse --short HEAD > commit-id"
    tag = readFile('commit-id').replace("\n", "").replace("\r", "")
    sh "sed 's#127.0.0.1:30400/jetty-alpine:version#127.0.0.1:30400/jetty-alpine:'$tag'#' deployment.yml | kubectl apply -f -"
  }
  
  stage ('Clean') {
    sh "docker rmi -f flask-jetty-alpine:1"
    sh "docker rmi -f ${imageName}"
  }
}
