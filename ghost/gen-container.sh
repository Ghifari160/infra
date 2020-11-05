#!/bin/bash

# Ghost container generator v0.1.0
# 
# Copyright (C) GHIFARI160
# Distributed under the terms of the MIT License

cd themes/attila
git apply --stat ../attila-modified.patch
git apply --check ../attila-modified.patch && git apply ../attila-modified.patch
npm i
grunt build
cd ../../
docker build -t infra/ghost .
