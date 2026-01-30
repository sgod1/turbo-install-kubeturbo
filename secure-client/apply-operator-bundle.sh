#!/bin/bash

source ${1:-"./client.env"}

bundle_yaml="./_yaml/operator_bundle.yaml"
_bundle_yaml="./_yaml/_operator_bundle.yaml"

if [[ ! -f $bundle_yaml ]]; then
   echo $bundlefile_yaml file not found
   exit 1
fi

tsc_namespace=${TSC_NAMESPACE:-$ENV_TSC_NAMESPACE}

if [[ -z $tsc_namespace ]]; then
   echo TNS_NAMESPACE variable required
   exit 1
fi

echo writing out $_bundle_yaml

# namespace and registry
sed "s/__NAMESPACE__/${tsc_namespace}/g" $bundle_yaml | sed "s|icr.io/cpopen|${KUBETURBO_REGISTRY}|g" > $_bundle_yaml

# if registry requires authentication...
# create docker registry secret registry-secret
# update service account in operator bundle with imagePullSecrets: [{name: registry-secret}]

echo applying $_bundle_yaml in $tsc_namespace namespace

set -x

kubectl create namespace $tsc_namespace
kubectl apply -n $tsc_namespace -f $_bundle_yaml
