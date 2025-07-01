pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
    }

    stages {
        stage('Init') {
            steps {
                echo 'Initializing Terraform...'
                sh 'terraform init'
            }
        }

        stage('Plan') {
            steps {
                echo 'Planning infrastructure...'
                sh 'terraform plan'
            }
        }

        stage('Apply') {
            steps {
                echo 'Applying Terraform changes...'
                sh 'terraform apply -auto-approve'
            }
        }

        stage('SSH into EC2') {
            steps {
                echo 'Connecting to public EC2 instance...'
                script {
                    def public_ip = sh(script: "terraform output -raw public_instance_ip", returnStdout: true).trim()
                    def key_path  = sh(script: "terraform output -raw private_key_path", returnStdout: true).trim()

                    sh """
                        chmod 400 ${key_path}
                        ssh -o StrictHostKeyChecking=no -i ${key_path} ubuntu@${public_ip} "hostname"
                    """
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed.'
        }
    }
}
