#!/bin/bash

# turbonomic secure client

outdir="_yaml"
mkdir -p $outdir

source_github_repo="https://raw.githubusercontent.com/IBM/t8c-client-operator/refs/heads/main/deploy/turbonomicclient.yaml"

set -x
curl -s --output-dir $outdir -L -O $source_github_repo || exit 1
