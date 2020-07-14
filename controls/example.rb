control 'azurerm_aks_cluster' do
  impact 'critical'
  title 'aks_cluster: configure Kubernetes cluster'
  describe azurerm_aks_cluster(resource_group: 'azkubernetes', name: 'gitops-demo-aks') do
  it { should exist }
  its('location') { should cmp 'eastus' }
  its ('tags'){ should cmp "Terraform" => "True" }
  its('properties.dnsPrefix') { should cmp 'gitlab' }
  its('properties.kubernetesVersion') { should cmp '1.16.10'}
  its('properties.agentPoolProfiles.first.name') { should cmp 'default' }
  its('properties.agentPoolProfiles.first.count') { should cmp 1 }
  its('properties.agentPoolProfiles.first.vmSize') { should cmp 'Standard_D2s_v3' }
  its('properties.provisioningState') { should cmp 'Succeeded' }
  its('properties.agentPoolProfiles.first.osType') { should cmp 'Linux' }
  its('properties.agentPoolProfiles.first.osProfile.diskSize') { should cmp >=30 }
  end
end
 
