#!/bin/bash

source ${1:-"client.env"}

ktv=${KUBETURBO_VERSION:-$ENV_KUBETURBO_VERSION}

if [[ -z $ktv ]]; then
   echo KUBETURBO_VERSION variable required
   exit 1
fi

podman=${PODMAN:-${ENV_PODMAN:-"podman"}}
tls_verify=${TLS_VERIFY:-$ENV_TLS_VERIFY}

platform="--platform $IMG_OS/$IMG_ARCH"

ktr=${KUBETURBO_REGISTRY}

$podman pull $platform $tls_vrify ${ktr}/t8c-client-operator:1.4.3 || exit1
$podman pull $platform $tls_verify ${ktr}/turbonomic/kube-state-metrics:v2.14.0 || exit 1

$podman pull $platform $tls_verify ${ktr}/turbonomic/tsc-site-resources:$ktv || exit 1
$podman pull $platform $tls_verify ${ktr}/turbonomic/rsyslog-courier:$ktv || exit 1
$podman pull $platform $tls_verify ${ktr}/turbonomic/skupper-site-controller:$ktv || exit 1
$podman pull $platform $tls_verify ${ktr}/turbonomic/skupper-router:$ktv || exit 1
$podman pull $platform $tls_verify ${ktr}/turbonomic/skupper-config-sync:$ktv || exit 1
$podman pull $platform $tls_verify ${ktr}/turbonomic/skupper-service-controller:$ktv || exit 1
