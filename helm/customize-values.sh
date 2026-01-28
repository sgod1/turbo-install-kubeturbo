#!/bin/bash

source ${1:-"cluster.env"}

outdir="_values"
mkdir -p $outdir

cat <<EOF > $outdir/values.yaml
image:
  repository: ${KUBETURBO_REGISTRY}/cpopen/turbonomic/kubeturbo
  tag: ${KUBETURBO_VERSION}
  pullPolicy: IfNotPresent
#  busyboxRepository: busybox
  imagePullSecret: ""
  cpufreqgetterRepository: ${KUBETURBO_REGISTRY}/cpopen/turbonomic/cpufreqgetter
  # cpufreqgetterTag is only valid for Kubeturbo version 8.18.5+, and valid options are the Turbo released version after 8.18.5 or latest otherwise.
  cpufreqgetterTag: ${KUBETURBO_VERSION}

# Specify 'turbo-cluster-reader' or 'turbo-cluster-admin' as role name instead of the default using
# the 'cluster-admin' role. A cluster role with this name will be created during deployment
# If using a role name other than the pre-defined role names, cluster role will not be created. This role should be
# existing in the cluster and should have the necessary permissions required for kubeturbo to work accurately.
roleName: "${KUBETURBO_ROLE}"

# Specify the name of clusterrolebinding
roleBinding: "turbo-all-binding"

# Specify the name of the serviceaccount
serviceAccountName: "turbo-user"

# Turbo server address
serverMeta:
  turboServer: ${TARGET_HOST}
  #proxy: http://username:password@proxyserver:proxyport or http://proxyserver:proxyport
  proxy: $(echo "http://${PROXY_USERNAME}:${PROXY_PASSWORD}@${PROXY_SERVER}:{$PROXY_PORT}" | base64)

# Turbo server api user and password stored in a secret or optionally specified as username and password
# The opsManagerUserName requires Turbo administrator role
restAPIConfig:
  turbonomicCredentialsSecretName: "turbonomic-credentials"
  # opsManagerUserName: <Turbo_username>
  # opsManagerPassword: <Turbo_password>

# For targetConfig, targetName provides better group naming to identify k8s clusters in UI
# - If no targetConfig is specified, a default targetName will be created from the apiserver URL in
#   the kubeconfig.
# - Specify a targetName only will register a probe with type Kubernetes-<targetName>, as well as
#   adding your cluster as a target with the name Kubernetes-<targetName>.
# - Specify a targetType only will register a probe without adding your cluster as a target.
#   The probe will appear as a Cloud Native probe in the UI with a type Kubernetes-<targetType>.
#
targetConfig:
  targetName: ${TARGET_NAME}
  targetType: ${TARGET_SUBTYPE}
EOF

