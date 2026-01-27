# Kubeturbo offline install on k8s cluster.

Turbonomic is installed as Saas.<br/>
Kubeturbo is installed on-prem.<br/>

### Mirror Kubeturbo container images to private container registry.<br/>
``
``

### Offline Kubeturbo operator install, no ODM.</br>

Operator yaml files are cloned to the bastion host from github repo and applied to the target cluster.<br/>
Operator CR is cloned from github repo, configured, and deployed.<br/>

```
bastion host on-prem -> ibm github repo, ibm container registry.<br/>

bastion host on-prem -> target cluster on-prem.<br/>

on-prem target cluster kubeturbo -> proxy -> turbonomic Saas.<br/>
```

Turbonomic target wizard in Turbonomic UI<br/>
Mirror container images.<br/>
Use Turbonomic target wizard in Turbonomic UI to configure and download operator installation script.<br/>
Login to the target cluster.<br>
Run installation script.<br/>


## Offline Kubeturbo helm chart install.<br/>

Configure on-prem helm repository as a proxy to external helm repository.<br/>

Pull Kubeturbo helm chart from on-prem helm repo.<br/>
Configure helm chart values file.<br/>
Install Kubeturbo helm chart on the target cluster.<br/>

```
on-prem helm repository -> proxy to external helm repository

on-prem target cluster kubeturbo -> proxy -> turbonomic Saas.<br/>
```

