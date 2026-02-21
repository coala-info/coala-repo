cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcbio-variation
label: bcbio-variation
doc: "bcbio-variation is a toolkit for analyzing genomic variation data. (Note: The
  provided input text contains system error logs and does not include the tool's help
  documentation; therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/chapmanb/bcbio.variation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcbio-variation:0.2.6--1
stdout: bcbio-variation.out
