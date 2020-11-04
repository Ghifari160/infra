#!/bin/bash

# ffmpeg x265/HEVC wrapper v0.1.0
# 
# Copyright (C) GHIFARI160
# Distributed under the terms of the MIT License

echo Input: ${1}
echo Target: ${2}

echo Starting Time: $(date)

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
