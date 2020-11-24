#!/bin/bash

# ffmpeg x265/HEVC wrapper v0.4.0
# 
# Copyright (C) GHIFARI160
# Distributed under the terms of the MIT License

USER=$(whoami)
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
            "description": "**User:** '${USER}'\n**Input:** '${1}'\n**Target:** '${2}'"
        }
    ]
}' \
    -H 'Content-Type: application/json' \
    $WEBHOOK_URL

# Uncomment these lines to transcode the input with H265/HEVC in a MP4 container
# ffmpeg -i ${1} \
#     -movflags faststart \
#     -c:v libx265 \
#     -profile:v main \
#     -preset faster \
#     -bf 2 \
#     -g 30 \
#     -tag:v hvc1 \
#     -x265-params open-gop=0 \
#     -crf 18 \
#     -pix_fmt yuv420p \
#     -c:a libfdk_aac \
#     -profile:a aac_low \
#     -b:a 384k \
#     ${2}

# Comment these lines if you don't want the extract the 6 audio tracks (from OBS footage) before
# transcoding the first audio track and the video track. The audio tracks are extracted as is, and
# encoded into the MP4 container with AAC-LC. The video track is encoded with H265/HEVC
ffmpeg -i ${1} \
    -map 0:a:0 \
    -c:a copy \
    ${2}_track1.aac \
    -map 0:a:1 \
    -c:a copy \
    ${2}_track2.aac \
    -map 0:a:2 \
    -c:a copy \
    ${2}_track3.aac \
    -map 0:a:3 \
    -c:a copy \
    ${2}_track4.aac \
    -map 0:a:4 \
    -c:a copy \
    ${2}_track5.aac \
    -map 0:a:5 \
    -c:a copy \
    ${2}_track6.aac \
    -map 0:v \
    -map 0:a:0 \
    -movflags faststart \
    -c:v libx265 \
    -profile:v main \
    -preset faster \
    -bf 2 \
    -g 30 \
    -tag:v hvc1 \
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
            "description": "**User:** '${USER}'\n**Input:** '${1}'\n**Target:** '${2}'"
        }
    ]
}' \
    -H 'Content-Type: application/json' \
    $WEBHOOK_URL
