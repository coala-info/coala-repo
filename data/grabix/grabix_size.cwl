cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grabix
  - size
label: grabix_size
doc: "Report the total number of lines in an indexed bgzipped file (minus the header).\n\nTool homepage: https://github.com/arq5x/grabix"
inputs:
  - id: bgzf_file
    type: File
    secondaryFiles:
      - .gbi
    doc: bgzipped file with its grabix index (.gbi) beside it
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Number of lines
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grabix:0.1.8--h077b44d_12
stdout: grabix_size.out
