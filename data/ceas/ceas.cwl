cwlVersion: v1.2
class: CommandLineTool
baseCommand: ceas
label: ceas
doc: "Cis-regulatory Element Annotation System (CEAS) is a tool for characterizing
  genome-wide protein-DNA interaction patterns from ChIP-seq and ChIP-chip data.\n
  \nTool homepage: https://github.com/jhardy/compass-ceaser-easing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ceas:1.0.2--py27_1
stdout: ceas.out
