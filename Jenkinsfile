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
  stage('post-build') {
    build 'SnykCli'
}
  stage('Snyk') {
    build 'SnykConsole'
}
 
 /*stage('ELK') {
    
    build 'ELK'
}*/
    stage('Preparation') { // for display purposes
       
        sh "az aks get-credentials --resource-group azkubernetes --name gitops-demo-aks"
        sh "pwd"
        sh "whoami"
        sh "/snap/bin/kubectl version --short --client"
        sh "/snap/bin/kubectl get nodes"
    }
    stage('Deploy and Configure Elasticsearch ') { // for display purposes
        sh "kubectl apply -f /var/lib/jenkins/elk-apps/new_elk/rbac.yaml"
        sleep 30
        sh "kubectl apply -f /var/lib/jenkins/elk-apps/new_elk/elasticsearch.yaml"
        sleep 30
        sh "kubectl apply -f /var/lib/jenkins/elk-apps/new_elk/elasticsearch-services.yaml"
        sleep 30

    }
     stage('Deploy and Configure Logstash') { // for display purposes
        sh "kubectl apply -f /var/lib/jenkins/elk-apps/new_elk/logstash-config.yaml"
        sleep 30
        sh "kubectl apply -f /var/lib/jenkins/elk-apps/new_elk/logstas-deployment.yaml"   
        sleep 30
        sh "kubectl apply -f /var/lib/jenkins/elk-apps/new_elk/logstash-service.yaml"
        sleep 30
    }
    stage('Deploy and Configure Filebeat') { // for display purposes
        sh "kubectl apply -f /var/lib/jenkins/elk-apps/new_elk/filebeat-agent.yaml"
        sleep 30
    }
    stage('Deploy and Configure Kibana') { // for display purposes
        sh "kubectl apply -f /var/lib/jenkins/elk-apps/new_elk/kibana-deployment.yaml"
        sleep 30
    }
    stage('Deploy apache web server') { // for display purposes
        sh "kubectl apply -f /var/lib/jenkins/elk-apps/new_elk/apache.yaml"
        sleep 30
    }
}

}
}

