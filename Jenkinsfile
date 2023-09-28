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
        stage('sonar analysis') {
            agent { label 'Docker' }
            steps {
                // performing sonarqube analysis with "withSonarQubeENV(<Name of Server configured in Jenkins>)"
                withSonarQubeEnv('SONAR_CLOUD') {
                    sh 'mvn clean package sonar:sonar -Dsonar.organization=javaproject_spc -Dsonar.projectKey=javaproject-spc_spc'
                }
            }
        }
        stage('Docker Image Build & Test') {
            agent { label 'Docker' }
            steps {
                sh 'sonar-scanner \
                    -Dsonar.organization=javaproject-spc \
                    -Dsonar.projectKey=javaproject-spc_spc \
                    -Dsonar.sources=. \
                    -Dsonar.host.url=https://sonarcloud.io'
            }
        }              
    }
}