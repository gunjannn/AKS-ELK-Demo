node {
  /*parameters {
    password (name: 'subscription_id')
    password (name: 'client_id')
    password (name: 'client_secret')
    password (name: 'tenant_id')
  }
  environment{
    AZURE_SUBSCRIPTION_ID = "${params.subscription_id}"
    AZURE_CLIENT_ID = "${params.client_id}"
    AZURE_TENANT_ID = "${params.tenant_id}"
    AZURE_CLIENT_SECRET = "${params.client_secret}"
}*/
  stage('SCM Checkout & cloning'){
    git url:  'https://github.com/gunjannn/c-i.git',branch: 'master'
}

  stage('Setterraformpath') {
    /*withCredentials([azureServicePrincipal('az')]) {*/
    script {
      def tfHome = tool name: 'terraform'
      env.PATH = "${tfHome}:${env.PATH}"
 }
      sh 'terraform version'
 }
           
      
  stage('TerraformApply') {
    /*withCredentials([azureServicePrincipal('az')]) {*/
      sh "terraform init -input=false"
      sh "terraform validate"
      sh 'terraform plan -out=tfplan -input=false -var-file=terraform.tfvars'
      sh "terraform apply -input=false tfplan -var-file=terraform.tfvars"
}
  stage('InfraTesting') {
    withCredentials([azureServicePrincipal('az')]) {
      sh "inspec exec AKS -t azure://64b70538-bc40-4492-9c4b-13f8b43e732d"
}
}	
}



/*node {
  stage('SCM Checkout & cloning'){
    git url:  'https://github.com/gunjannn/c-i.git',branch: 'master'
}

  stage('Setterraformpath') {
    script {
      def tfHome = tool name: 'terraform'
      env.PATH = "${tfHome}:${env.PATH}"
 }
      sh 'terraform version'
 }
            
      
  stage('TerraformApply') {

    sh "terraform init"
}
   
   stage('TerraformPlan') { 
      sh "terraform plan -out=tfplan -input=false"
}
      
  stage('changing dir') {
    dir ('c-i') {
    sh 'pwd'
}
}

  stage('TerraformApply') {
    sh "terraform apply -input=false tfplan"
}

  stage('InfraTesting') {
  withCredentials([azureServicePrincipal('az')]) {
   
    sh "inspec exec AKS -t azure://64b70538-bc40-4492-9c4b-13f8b43e732d"
}	
}
}*/
