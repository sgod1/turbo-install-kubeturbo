#!/bin/bash

source ${1:-"./client.env"}

ktv=${KUBETURBO_VERSION:-$ENV_KUBETURBO_VERSION}

if [[ -z $ktv ]]; then
   echo KUBETURBO_VERSION variable required
   exit 1
fi

tsc_namespace=${TSC_NAMESPACE:-$ENV_TSC_NAMESPACE}

if [[ -z $tsc_namespace ]]; then
   echo TNS_NAMESPACE variable required
   exit 1
fi

outdir="_yaml"
outclient="_turbonomicclient.yaml"

outyaml=$outdir/$outclient

mkdir -p $outdir

echo writing out $outyaml

cat <<EOF > $outyaml
apiVersion: clients.turbonomic.ibm.com/v1alpha1
kind: TurbonomicClient
metadata:
  name: turbonomicclient-release
spec:
  global:
    version: $ktv
    #imagePullSecrets: [{name: "registry-secret"}]
  probes:
    actionScript:
      enabled: $enable_actionScript
    actionStreamKafka:
      enabled: $enable_actionStreamKafka
    appDynamics:
      enabled: $enable_appDynamics
    compellent:
      enabled: $enable_compellent
    datadog:
      enabled: $enable_datadog
    dynatrace:
      enabled: $enable_dynatrace
    flexera:
      enabled: $enable_flexera
    hds:
      enabled: $enable_hds
    horizon:
      enabled: $enable_horizon
    hpe3par:
      enabled: $enable_hpe3par
    hyperFlex:
      enabled: $enable_hyperFlex
    hyperV:
      enabled: $enable_hyperV
    ibmStorageFlashSystem:
      enabled: $enable_ibmStorageFlashSystem
    instana:
      enabled: $enable_instana
    jvm:
      enabled: $enable_jvm
    mssql:
      enabled: $enable_mssql
    mysql:
      enabled: $enable_mysql
    netApp:
      enabled: $enable_netApp
    newRelic:
      enabled: $enable_newRelic
    nutanix:
      enabled: $enable_nutanix
    oneView:
      enabled: $enable_oneView
    oracle:
      enabled: $enable_oracle
    powerVM:
      enabled: $enable_powerVM
    pure:
      enabled: $enable_pure
    scaleIO:
      enabled: $enable_scaleIO
    serviceNow:
      enabled: $enable_serviceNow
    snmp:
      enabled: $enable_snmp
    terraform:
      enabled: $enable_terraform
    tomcat:
      enabled: $enable_tomcat
    ucs:
      enabled: $enable_ucs
    vCenter:
      enabled: $enable_vCenter
    vmax:
      enabled: $enable_vmax
    vmm:
      enabled: $enable_vmm
    vplex:
      enabled: $enable_vplex
    webLogic:
      enabled: $enable_webLogic
    webSphere:
      enabled: $enable_webSphere
    wmi:
      enabled: $enable_wmi
    xtremIO:
      enabled: $enable_xtremIO
EOF

# apply client yaml
echo applying $outyaml in namespace $tsc_namespace

set -x
kubectl apply -f $outyaml -n $tsc_namespace
