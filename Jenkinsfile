node {
   withCredentials([azureServicePrincipal(credentialsId: 'az',
                                    subscriptionIdVariable: 'subscription_id',
                                    clientIdVariable: 'client_id',
                                    clientSecretVariable: 'client_secret',
                                    tenantIdVariable: 'tenant_id')]) {
    sh 'az login --service-principal -u $client_id -p $client_secret -t $tenant_id'
}
  stage('TerraformApply'){
    git url:  'https://github.com/gunjannn/AKS-ELK-Demo.git',branch: 'master'
  script {
    def tfHome = tool name: 'terraform'
    env.PATH = "${tfHome}:${env.PATH}"
    sh 'terraform version'
    sh "terraform init -input=false"
    sh "terraform validate"
    withCredentials([azureServicePrincipal(credentialsId: 'az',
                                    subscriptionIdVariable: 'subscription_id',
                                    clientIdVariable: 'client_id',
                                    clientSecretVariable: 'client_secret',
                                    tenantIdVariable: 'tenant_id')]) {
    sh "terraform plan -var='client_id=$client_id' -var='subscription_id=$subscription_id' -var='client_secret=$client_secret' -var='tenant_id=$tenant_id' -out=tfplan -input=false"
    sh "terraform apply -input=false tfplan"
}
  } 
  stage('InfraTesting') {
    withCredentials([azureServicePrincipal('az')]) {
      sh "inspec exec AKS -t azure://"
}
}
}
}
