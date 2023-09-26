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
        stage('Sonar Analysis') {
            agent { label 'Docker' }
            steps {
                withSonarQubeEnv('SONARQUBE') {
                    sh 'mvn clean package sonar:sonar -Dsonar.organization=javaproject'
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