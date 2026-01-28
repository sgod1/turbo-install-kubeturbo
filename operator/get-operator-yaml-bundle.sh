#!/bin/bash

source ${1:-"cluster.env"}

kubeturbo_version=${KUBETURBO_VERSION:-$ENV_KUBETURBO_VERSION}

if [[ -z $kubeturbo_version ]]; then
   echo KUBETURBO_VERSION variable required
   exit 1
fi

outdir="_yaml"
mkdir -p $outdir

source_github_repo="https://raw.githubusercontent.com/IBM/turbonomic-container-platform"
operator_yaml_path="kubeturbo/operator/operator-bundle.yaml"
kubeturbo_operator_release=$kubeturbo_version

set -x
curl -s --output-dir $outdir  -O $source_github_repo/$kubeturbo_operator_release/$operator_yaml_path || exit 1
