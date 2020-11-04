# Renderer

Provisioning tool for cloud-based, single machine video encoding/transcoding.

## Included tools

Provisioned render nodes carry the following tools:

| Tool Name       | Description                                                                     | Origin              |
|-----------------|---------------------------------------------------------------------------------|---------------------|
| `fdkaac`        | Audio encoding tool                                                             | Installed with Apt  |
| `ffmpeg`        | Cross-platform video and audio encoding solution                                | Installed with Apt  |
| `ffmpeg-render` | Wrapper around `ffmpeg` for x265/HEVC encoding with the YouTube ingest settings | In-house            |
| `medhash-chk`   | medhash checker                                                                 | In-house            |
| `medhash-gen`   | medhash generator                                                               | In-house            |
| `rsync`         | Remote file transfer utility                                                    | Included in base OS |
| `x264`          | H.264/AVC encoder                                                               | Installed with Apt  |
| `x265`          | H.265/HEVC encoder                                                              | Installed with Apt  |

**Note:** DigitalOcean monitoring agent will be installed as a part of the provisioning process.
Other cloud providers should provide some sort of monitoring agent. Those should be installed under
the provisioning process.

## Intended use

The intended use for each provisioned render nodes is to transfer the intended footage into some
sort of block storage, run `ffmpeg-render`, and transfer back the rendered/transcoded footage. A
medhash sums file should be generated prior to every file transfer and checked against following a
successful transfer.

**Note:** Rendering/transcoding automation is not a part of the provisioned render nodes. Manual
execution is still the intended use case. Rendering/transcoding can be done in the background
using Linux screen sessions. Monitoring of background jobs can be done by looking at the CPU
usage of each node (during the a job, the CPU usage should hover at around 90-100%).

## Use by GHIFARI160

GHIFARI160 use a provisioned render node for the transcoding of livestream VODs. We use CPU
Optimized nodes on DigitalOcean (`c2-2vcpu-4gb`). Footage transfers are done with rsync over
SSH with the `--progress` flag to enabled transfer monitoring.
