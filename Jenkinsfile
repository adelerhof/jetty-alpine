node {
  stage('Maven build') {
    checkout scm
    sh "git rev-parse --short HEAD > commit-id"
    tag = readFile('commit-id').replace("\n", "").replace("\r", "")
    appname = "jetty-alpine:"
    env.registryHost = "127.0.0.1:30400/"
    env.imageName = "${registryHost}${appname}${tag}"
    
    docker.image('maven:3.6.1-jdk-11').inside {
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
    sh "docker tag jetty-alpine:1 ${imageName}"
    sh "docker push ${imageName}"
  }
  
  stage ('Deploy to Registry') {
    sh "sed 's#127.0.0.1:30400/jetty-alpine:version#127.0.0.1:30400/jetty-alpine:'$tag'#' deployment.yml | kubectl apply -f -"
  }
  
  stage ('Clean') {
    sh "docker rmi -f jetty-alpine:1"
    sh "docker rmi -f ${imageName}"
  }
}
