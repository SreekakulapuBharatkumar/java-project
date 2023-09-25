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
            agent(label 'Build')
            steps {
                withSonarQubeEnv('SONAR_CLOUD') {
                    sh 'mvn clean verify sonar:sonar'
                }
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