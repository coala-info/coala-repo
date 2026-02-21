cwlVersion: v1.2
class: CommandLineTool
baseCommand: hic-straw
label: hic-straw
doc: "A tool for extracting data from .hic files\n\nTool homepage: https://github.com/aidenlab/straw"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hic-straw:1.3.1--py311hb99c5bc_6
stdout: hic-straw.out
