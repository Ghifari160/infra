#!/bin/bash

# medhash checker v0.1.0
# 
# Copyright (C) GHIFARI160
# Distributed under the terms of the MIT License

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Running tool in macOS"

    echo "Checking files in $PWD"
    shasum -c sums.txt
elif [[ "$OSTYPE" == "linux"* ]]; then
    echo "Running tool in linux"

    echo "Checking files in $PWD"
    cat sums.txt | sha256sum --check
fi

echo "Done!"
