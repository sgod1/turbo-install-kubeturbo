#!/bin/bash

curl -s https://api.github.com/repos/IBM/turbonomic-container-platform/tags | grep '"name":' | cut -d '"' -f 4
