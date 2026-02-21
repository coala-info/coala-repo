cwlVersion: v1.2
class: CommandLineTool
baseCommand: toil
label: toil
doc: "Toil is a scalable, efficient, and cross-platform pipeline management system,
  written entirely in Python, and designed to run workflows on a variety of environments.\n
  \nTool homepage: https://toil.ucsc-cgl.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/toil:7.0.0--pyhdfd78af_0
stdout: toil.out
