#!/bin/bash

source ${1:-"./client.env"}

ktv=${KUBETURBO_VERSION:-$ENV_KUBETURBO_VERSION}

if [[ -z $ktv ]]; then
   echo KUBETURBO_VERSION variable required
   exit 1
fi

vmgr_yaml="./_yaml/versionmanager.yaml"

if [[ ! -f $vmgr_yaml ]]; then
   echo $vmgr_yaml file not found
   exit 1
fi

tsc_namespace=${TSC_NAMESPACE:-$ENV_TSC_NAMESPACE}

if [[ -z $tsc_namespace ]]; then
   echo TNS_NAMESPACE variable required
   exit 1
fi

echo applying $vmgr_yaml in $tsc_namespace namespace

set -x
kubectl apply -f $vmgr_yaml -n $tsc_namespace
