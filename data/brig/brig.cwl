cwlVersion: v1.2
class: CommandLineTool
baseCommand: brig
label: brig
doc: "Blast Ring Image Generator (BRIG) is a tool for generating comparative genomics
  images.\n\nTool homepage: https://github.com/Mojang/brigadier"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/brig:v0.95dfsg-2-deb_cv1
stdout: brig.out
