node {
  stage('TerraformApply'){
    git url:  'https://github.com/gunjannn/AKS-ELK-Demo.git',branch: 'master'
  script {
    def tfHome = tool name: 'terraform'
    env.PATH = "${tfHome}:${env.PATH}"
    sh 'terraform version'
    sh "terraform init -input=false"
    sh "terraform validate"
    sh "terraform plan -out=tfplan -input=false -var-file=var_values.tfvars"
    sh "terraform apply -input=false tfplan"
}
  
  stage('InfraTesting') {
    withCredentials([azureServicePrincipal('az')]) {
      sh "inspec exec AKS -t azure://64b70538-bc40-4492-9c4b-13f8b43e732d"
}
}
}
}
