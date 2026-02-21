cwlVersion: v1.2
class: CommandLineTool
baseCommand: platypus-variant
label: platypus-variant
doc: "A tool for variant detection in next-generation sequencing data.\n\nTool homepage:
  http://www.well.ox.ac.uk/platypus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/platypus-variant:0.8.1.2--py27h4fe4a89_4
stdout: platypus-variant.out
