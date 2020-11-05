#!/bin/bash

# Renderer cloud-init generator v0.1.0
# 
# Copyright (C) GHIFARI160
# Distributed under the terms of the MIT License

echo "#cloud-config" > ci.yaml
echo "" >> ci.yaml

cat cloud-init/apt.yaml >> ci.yaml
cat cloud-init/packages.yaml >> ci.yaml
cat cloud-init/snap.yaml >> ci.yaml

echo "write_files:" >> ci.yaml
echo "  - path: /etc/ssh/sshd_config" >> ci.yaml
echo "    content: |" >> ci.yaml
# cat ../ssh/sshd_config >> ci.yaml
sed "s/^/      /" ../ssh/sshd_config >> ci.yaml

echo "  - path: /usr/bin/medhash-gen" >> ci.yaml
echo "    content: |" >> ci.yaml
sed "s/^/      /" scripts/medhash-gen.sh >> ci.yaml

echo "  - path: /usr/bin/medhash-chk" >> ci.yaml
echo "    content: |" >> ci.yaml
sed "s/^/      /" scripts/medhash-chk.sh >> ci.yaml

echo "  - path: /usr/bin/ffmpeg-render" >> ci.yaml
echo "    content: |" >> ci.yaml
sed "s/^/      /" scripts/ffmpeg-render.sh >> ci.yaml

echo "  - path: /automation/ffmpeg-render-webhook" >> ci.yaml
echo "    content: |" >> ci.yaml
sed "s/^/      /" webhooks/ffmpeg-render-webhook.txt >> ci.yaml

cat cloud-init/runcmd.yaml >> ci.yaml

cat cloud-init/ssh.yaml >> ci.yaml

echo "ssh_keys:" >> ci.yaml
echo "  rsa_private: |" >> ci.yaml
sed "s/^/    /" ssh/ssh_host_rsa_key >> ci.yaml
sed "s/^/  rsa_public: /" ssh/ssh_host_rsa_key.pub >> ci.yaml

echo "  dsa_private: |" >> ci.yaml
sed "s/^/    /" ssh/ssh_host_dsa_key >> ci.yaml
sed "s/^/  dsa_public: /" ssh/ssh_host_dsa_key.pub >> ci.yaml

echo "  ecdsa_private: |" >> ci.yaml
sed "s/^/    /" ssh/ssh_host_ecdsa_key >> ci.yaml
sed "s/^/  ecdsa_public: /" ssh/ssh_host_ecdsa_key.pub >> ci.yaml

echo "users:" >> ci.yaml
sed "s/^/  /" cloud-init/user-ghifari.yaml >> ci.yaml

cat cloud-init/final_message.yaml >> ci.yaml
