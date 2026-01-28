#!/bin/bash

source ${1:-"cluster.env"}

KUBETURBO_VERSION=${KUBETURBO_VERSION:-$ENV_KUBETURBO_VERSION}

KUBETURBO_REGISTRY=${KUBETURBO_REGISTRY:-$ENV_KUBETURBO_REGISTRY}
KUBETURBO_REGISTRY_USERNAME=${KUBETURBO_REGISTRY_USERNAME:-$ENV_KUBETURBO_REGISTRY_USERNAME}
KUBETURBO_REGISTRY_PASSWORD=${KUBETURBO_REGISTRY_PASSWORD:-$ENV_KUBETURBO_REGISTRY_PASSWORD}

if [[ -z $KUBETURBO_VERSION ]]; then
   echo KUBETURBO_VERSION variable required
   exit 1
fi

if [[ -z $KUBETURBO_REGISTRY ]]; then
   echo KUBETURBO_REGISTRY variable required
   exit 1
fi

# podman cli
podman=${PODMAN:-${ENV_PODMAN:-"podman"}}

#tls_verify="--tls-verify"
tls_verify="--tls-verify=false"

platform="--platform $IMG_OS/$IMG_ARCH"

platform_subpath="$IMG_OS_$IMG_ARCH"
#registry=$KUBETURBO_REGISTRY/$platform_subpath

registry=$KUBETURBO_REGISTRY
tag=$KUBETURBO_VERSION

operator_repository="cpopen/kubeturbo-operator"
kubeturbo_repository="cpopen/turbonomic/kubeturbo"
cpufreq_repository="cpopen/turbonomic/cpufreqgetter"

set -x

$podman pull $platform icr.io/$operator_repository:$tag || exit 1
$podman pull $platform icr.io/$kubeturbo_repository:$tag || exit 1
$podman pull $platform icr.io/$cpufreq_repository:$tag || exit 1

$podman tag icr.io/$operator_repository:$tag $registry/$operator_repository:$tag || exit 1
$podman tag icr.io/$kubeturbo_repository:$tag $registry/$kubeturbo_repository:$tag || exit 1
$podman tag icr.io/$cpufreq_repository:$tag $registry/$cpufreq_repository:$tag || exit 1

if [[ -n $KUBETURBO_REGISTRY_PASSWORD ]]; then
$podman login $tls_verify --username $KUBETURBO_REGISTRY_USERNAME --password $(echo $KUBETURBO_REGISTRY_PASSWORD|base64 -d) $KUBETURBO_REGISTRY || exit 1
fi

$podman push $tls_verify $registry/$operator_repository:$tag || exit 1
$podman push $tls_verify $registry/$kubeturbo_repository:$tag || exit 1
$podman push $tls_verify $registry/$cpufreq_repository:$tag || exit 1
