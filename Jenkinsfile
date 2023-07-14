def branch = "main"
def remote = "origin"
def directory = "~/wayshub-backend"
def server = "fama@103.191.92.211"
def cred = "wayshub1"
def image1 = "nobody1305/fama-backend:latest"
def image2 = "nobody1305/fama-database:latest"

pipeline{
    agent any
    stages{
        stage('repo pull'){
            steps{
                sshagent([cred]){
                    sh """ssh -o StrictHostKeyChecking=no ${server} << EOF
		    docker compose down
                    cd ${directory}
                    git pull ${remote} ${branch}
                    exit
                    EOF"""
                    }
                }
            }

	  stage('docker compose mysql'){
            steps{
                sshagent([cred]){
                    sh """ssh -o StrictHostKeyChecking=no ${server} << EOF
                    docker compose -f compose-mysql.yml up -d
                    exit
                    EOF"""
                    }
                }
            }

	 stage('docker build'){
            steps{
                sshagent([cred]){
                    sh """ssh -o StrictHostKeyChecking=no ${server} << EOF
                    cd ${directory}
                    docker build -t fama-backend .
                    exit
                    EOF"""
                    }
                }
            }

        stage('docker compose'){
            steps{
                sshagent([cred]){
                    sh """ssh -o StrictHostKeyChecking=no ${server} << EOF
                    cd ${directory}
                    docker compose up -d
                    exit
                    EOF"""
                    }
                }
            }
	
	 stage('docker push'){
            steps{
                sshagent([cred]){
                    sh """ssh -o StrictHostKeyChecking=no ${server} << EOF
                    cd ${directory}
		    docker tag fama-backend:latest ${image1}
		    docker tag fama-database:latest ${image2}
                    docker push ${image1}
		    docker push ${image2}
                    exit
                    EOF"""
                    }
                }
            }
        }
    }
