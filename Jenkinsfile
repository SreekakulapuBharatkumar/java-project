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
        stage('Build') {
            agent { label 'Docker' }
            tools { maven 'Maven' }
            steps{
                sh 'mvn package'
            }
        }
        stage('JUNIT') {
            agent { label 'Docker' }
            steps {
                archiveArtifacts artifacts: '**/target/spring-petclinic-3.1.0-SNAPSHOT.jar',
                                 onlyIfSuccessful: true
                junit testResults: '**/surefire-reports/TEST-*.xml'
            }
        }
        stage('Docker Image Build & Test') {
            agent { label 'Docker' }
            steps {
                sh 'docker image build -t spc:latest .'
                sh 'docker image tag spc:latest bharatnar/spc:latest'
                sh 'docker image tag spc:latest bharatnar/spc:${BUILD_NUMBER}'
                sh 'docker image push bharatnar/spc:latest'
                sh 'docker image push bharatnar/spc:${BUILD_NUMBER}'
            }
        }                
    }
}