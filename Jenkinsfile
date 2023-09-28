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
            steps {
                withSonarQubeEnv('SONARCLOUD') {
                sh 'mvn clean package sonar:sonar -Dsonar.Organizations=javaproject-spc'
                }
            }
        }
        stage('Docker Image Build & Test') {
            agent { label 'Docker' }
            steps {
                sh 'docker image build -t spc:latest .'
            }
        }              
    }
}