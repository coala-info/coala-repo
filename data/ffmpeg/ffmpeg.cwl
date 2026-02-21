cwlVersion: v1.2
class: CommandLineTool
baseCommand: ffmpeg
label: ffmpeg
doc: "A complete, cross-platform solution to record, convert and stream audio and
  video.\n\nTool homepage: https://github.com/FFmpeg/FFmpeg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ffmpeg:7.1.1
stdout: ffmpeg.out
