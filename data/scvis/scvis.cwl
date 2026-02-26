cwlVersion: v1.2
class: CommandLineTool
baseCommand: scvis
label: scvis
doc: "Learning a parametric mapping for high-dimensional single cell data or mapping
  high-dimensional single cell data to a low-dimensional space given a pretrained
  mapping\n\nTool homepage: https://bitbucket.org/jerry00/scvis-dev/commits/all"
inputs:
  - id: subcommand
    type: string
    doc: "Subcommand to run: 'train' or 'map'"
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scvis:0.1.0--scvis_0
stdout: scvis.out
