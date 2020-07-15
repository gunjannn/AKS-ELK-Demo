node {
  /*parameters {
    password (name: 'subscription_id')
    password (name: 'client_id')
    password (name: 'client_secret')
    password (name: 'tenant_id')
  }*/
  /*environment{
    subscription_id = var.subscription_id
    client_id = var.client_id
    tenant_id = var.tenant_id
    client_secret = var.client_secret
  }*/
  stage('SCM Checkout & cloning'){
    git url:  'https://github.com/gunjannn/AKS-ELK-Demo.git',branch: 'master'
}

  stage('Setterraformpath') {
    withCredentials([azureServicePrincipal('az')]) {
    script {
      def tfHome = tool name: 'terraform'
      env.PATH = "${tfHome}:${env.PATH}"
 }
      sh 'terraform version'
 }
           
      
  stage('TerraformApply') {
    withCredentials([azureServicePrincipal('az')]) {
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
  }
