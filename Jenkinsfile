pipeline {
    agent none
    triggers { pollSCM ('* * * * *') }
    stages {
        stage('vcs') {
            agent { label 'Docker' }
            steps{
                    git url: 'https://github.com/SreekakulapuBharatkumar/java-project.git',
                        branch: 'dev'
            }
        }
        stage('SonarQube Analysis') {
            agent { label 'Docker' }
            def scannerHome = tool 'SonarQube_Scanner'
            steps {
                withSonarQubeEnv('SONARQUBE') {
                sh """/var/lib/jenkins/tools/hudson.plugins.sonar.SonarRunnerInstallation/SonarQube/bin/sonar-scanner \
                    -D sonar.projectVersion=1.0-SNAPSHOT \
                    -D sonar.login=admin \
                    -D sonar.password=admin \
                    -D sonar.projectBaseDir=/var/lib/jenkins/workspace/jenkins-sonar/ \
                    -D sonar.projectKey=my-app1 \
                    -D sonar.sourceEncoding=UTF-8 \
                    -D sonar.language=java \
                    -D sonar.sources=my-app/src/main \
                    -D sonar.tests=my-app/src/test \
                    -D sonar.host.url=http://34.211.24.132:8383/"""
                }
            }
        }
        stage('Docker Image Build & Test') {
            agent { label 'Docker' }
            steps {
                sh 'docker image build -t spc:latest .'
            }
        } 
        stage('post build') {
            agent { label 'Docker' }
            steps {
                archiveArtifacts artifacts: '**/target/spring-petclinic-3.1.0-SNAPSHOT.jar',
                                 onlyIfSuccessful: true
                junit testResults: '**/surefire-reports/TEST-*.xml'
            }
        }               
    }
}