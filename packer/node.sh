#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
packer build -var "current_dir=$CURRENT_DIR" "$CURRENT_DIR/node.json"
