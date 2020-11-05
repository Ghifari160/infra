#!/bin/bash

# Renderer SSH host keys generator v0.1.0
# 
# Copyright (C) GHIFARI160
# Distributed under the terms of the MIT License

ssh-keygen -f ssh_host_rsa_key -N "" -t rsa -b 4096 -C root@renderer
ssh-keygen -f ssh_host_dsa_key -N "" -t dsa -C root@renderer
ssh-keygen -f ssh_host_ecdsa_key -N "" -t ecdsa -b 521 -C root@renderer
