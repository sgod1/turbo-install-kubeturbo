# Kubeturbo offline install on k8s cluster.

Turbonomic is installed as `Saas`.<br/>
Kubeturbo is installed to `on-prem` target cluster.<br/>

### Mirror Kubeturbo container images to private container registry.<br/>
Mirror container images before deploying Kubeturbo operator.<br/>

Change to the `operator` directory.<br/>

Check available kubeturbo versions:<br/>
```
show_release_versions.sh
```

Update `cluster.env` file with required variables.<br/>

Set `KUBETURBO_VERSION` to a version matching Turbonomic deployment.<br/>
```
# env var ENV_KUBETURBO_VERSION
KUBETURBO_VERSION=""

IMG_OS="linux"
IMG_ARCH="amd64"

# env var ENV_KUBETURBO_REGISTRY
KUBETURBO_REGISTRY=""

# env var ENV_KUBETURBO_REGISTRY_USERNAME
KUBETURBO_REGISTRY_USERNAME=""

# env var KUBETURBO_REGISTRY_PASSWORD
KUBETURBO_REGISTRY_PASSWORD=""
```
Mirror images:<br/>
```
mirror-images.sh
```

### Offline Kubeturbo operator install, no ODM.</br>

```
bastion host on-prem -> ibm github repo, ibm container registry.

bastion host on-prem -> target cluster on-prem.

on-prem target cluster kubeturbo -> proxy -> turbonomic Saas.
```

Deploy `Kubeturbo` operator with *Turbonomic target wizard* in Turbonomic UI<br/>
- Log into Turbonomic UI and navigate to `Settings/Target Configuration/Add Target/Kubernetes`.<br/>
- Set cluster name.<br/>
- Set private image repository and credentials.<br/>
- Set proxy hostname, port, and credentials.<br/>
- Download generated script.<br/>

Copy generated script to the `bastion` host.<br/>

On the 'bastion host`<br/>
- Make sure script `KUBETURBO_VERSION` and `KUBETURBO_REGISTRY` match values in `cluster.env` and mirror container images.<br/>
- Run installation script.<br/>

### Offline Kubeturbo helm chart install.<br/>

Configure on-prem helm repository as a proxy to external helm repository.<br/>

Pull Kubeturbo helm chart from on-prem helm repo.<br/>
Configure helm chart values file.<br/>
Install Kubeturbo helm chart on the target cluster.<br/>

```
on-prem helm repository -> proxy to external helm repository

on-prem target cluster kubeturbo -> proxy -> turbonomic Saas.<br/>
```

