# Kubeturbo offline install on k8s cluster.

Turbonomic is installed as Saas.<br/>
Kubeturbo is installed on-prem.<br/>

Mirror container images to private container registry.<br/>
``
``

Offline operator install, no ODM.</br>

Operator yaml files are cloned to the bastion host from github repo and applied to the target cluster.<br/>
Operator CR is cloned from github repo, configured, and deployed.<br/>

```
bastion host on-prem -> ibm github repo, ibm container registry.<br/>

bastion host on-prem -> target cluster on-prem.<br/>

on-prem target cluster kubeturbo -> proxy -> turbonomic Saas.<br/>
```
