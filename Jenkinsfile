pipeline{
    agent any
    stages{
        stage("TF Init"){
            steps{
               sh "wget <a href="https://releases.hashicorp.com/terraform/1.3.5/terraform_1.3.5_linux_amd64.zip">https://releases.hashicorp.com/terraform/1.3.5/terraform_1.3.5_linux_amd64.zip</a>"
               sh "sudo unzip terraform_1.3.5_linux_amd64.zip -d /usr/local/bin"
               sh "terraform -version"
               sh "yum install terraform -y"
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
