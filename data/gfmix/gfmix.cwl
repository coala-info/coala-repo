cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfmix
label: gfmix
doc: "Error: Need sequence file: -s seqfile\n\nTool homepage: https://www.mathstat.dal.ca/~tsusko/doc/gfmix.pdf"
inputs:
  - id: seqfile
    type: File
    doc: sequence file
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfmix:1.0.2--hdbdd923_2
stdout: gfmix.out
