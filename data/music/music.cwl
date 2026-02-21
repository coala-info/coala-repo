cwlVersion: v1.2
class: CommandLineTool
baseCommand: music
label: music
doc: "The provided text does not contain help information or usage instructions; it
  is a container runtime error log indicating a failure to build the SIF format due
  to lack of disk space.\n\nTool homepage: https://github.com/lyswhut/lx-music-desktop"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/music:1.0.0--h2d50403_2
stdout: music.out
