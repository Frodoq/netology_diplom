#!/usr/bin/env bash
set -e
cd "$(dirname "$0")/../terraform/infra"
terraform init -input=false
terraform plan -input=false
