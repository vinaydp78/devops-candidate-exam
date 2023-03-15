pipeline{
    agent any
    stages{
        stage("TF Init"){
            steps{
               sh "curl https://2xfhzfbt31.execute-api.eu-west-1.amazonaws.com/candidate-email_serverless_lambda_stage/data"
               sh "yum install -y yum-utils "
               sh "yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo"
               sh "yum -y install terraform"
               sh "terraform -version"
               sh "terraform init"
            }
        }
        stage("TF Validate"){
            steps{
                echo "Validating Terraform Code"
            }
        }
        stage("TF Plan"){
            steps{
                echo "Executing Terraform Plan"
            }
        }
        stage("TF Apply"){
            steps{
                echo "Executing Terraform Apply"
            }
        }
        stage("Invoke Lambda"){
            steps{
                echo "Invoking your AWS Lambda"
            }
        }
    }
}
