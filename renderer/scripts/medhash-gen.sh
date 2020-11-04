#!/bin/bash

# medhash generator v0.1.0
# 
# Copyright (C) GHIFARI160
# Distributed under the terms of the MIT License

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Running tool in macOS"

    echo "Generating hash files in $PWD"
    find . -type f \( ! -iname "sums.txt" ! -iname ".DS_Store" \) -exec shasum -a 256 {} ";" > sums.txt
    
    echo "Sanity checking hash files"
    shasum -c sums.txt
elif [[ "$OSTYPE" == "linux"* ]]; then
    echo "Running tool in linux"

    echo "Generating hash files in $PWD"
    find . -type f \( ! -iname "sums.txt" ! -iname ".DS_Store" \) -exec sha256sum {} ";" > sums.txt
    
    echo "Sanity checking hash files"
    cat sums.txt | sha256sum --check
fi

echo "Done!"
