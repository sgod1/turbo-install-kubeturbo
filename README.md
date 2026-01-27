# Kubeturbo offline install on k8s cluster.

Turbonomic is installed as Saas.<br/>
Kubeturbo is installed on-prem.<br/>

Offline operator install, no ODM.</br>

Operator yaml files are cloned to the bastion host from github repo and applied to the target cluster.<br/>
Operator CR is cloned from github repo, configured, and deployed.<br/>

on-prem bastion host -> private container registry.<br/>
on-prem bastion host -> proxy -> turbonomic Saas.<br/>
