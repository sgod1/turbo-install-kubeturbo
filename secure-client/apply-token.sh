#!/bin/bash

source "./client.env"

token_json=$1

tsc_namespace=${TSC_NAMESPACE:-$ENV_TSC_NAMESPACE}

if [[ -z $tsc_namespace ]]; then
   echo TNS_NAMESPACE variable required
   exit 1
fi

if [[ ! -f $token_json ]]; then
   echo token json $token_json not found
   exit
fi

echo applying $token_json token in $tsc_namespace namespace

set -x
kubectl apply -f $token_json -n $tsc_namespace

