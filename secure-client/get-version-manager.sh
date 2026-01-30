#!/bin/bash

# turbonomic secure client version manager

outdir="_yaml"
mkdir -p $outdir

source_github_repo="https://raw.githubusercontent.com/IBM/t8c-client-operator/refs/heads/main/deploy/versionmanager.yaml"

set -x
curl -s --output-dir $outdir -L -O $source_github_repo || exit 1
