#!/bin/bash

# ffmpeg x265/HEVC wrapper v0.1.0
# 
# Copyright (C) GHIFARI160
# Distributed under the terms of the MIT License

WEBHOOK_AUTHOR=renderer.gassets.space
WEBHOOK_URL=$(cat /automation/ffmpeg-render-webhook)

echo Input: ${1}
echo Target: ${2}

echo Starting Time: $(date)

curl -d '{
    "embeds": [
        {
            "color": 30656,
            "author": { "name": "'${WEBHOOK_AUTHOR}'" },
            "title": "Render Started",
            "description": "**Input:** '${1}'\n**Target:** '${2}'"
        }
    ]
}' \
    -H 'Content-Type: application/json' \
    $WEBHOOK_URL

ffmpeg -i ${1} \
    -movflags faststart \
    -c:v libx265 \
    -profile:v main \
    -bf 2 \
    -g 30 \
    -x265-params open-gop=0 \
    -crf 18 \
    -pix_fmt yuv420p \
    -c:a libfdk_aac \
    -profile:a aac_low \
    -b:a 384k \
    ${2}

echo Ending Time: $(date)

curl -d '{
    "embeds": [
        {
            "color": 65280,
            "author": { "name": "'${WEBHOOK_AUTHOR}'" },
            "title": "Render Completed",
            "description": "**Input:** '${1}'\n**Target:** '${2}'"
        }
    ]
}' \
    -H 'Content-Type: application/json' \
    $WEBHOOK_URL
