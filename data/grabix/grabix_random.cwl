cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grabix
  - random
label: grabix_random
doc: "Extract random lines (the header is printed first) from an indexed bgzipped file.\n\nTool homepage: https://github.com/arq5x/grabix"
inputs:
  - id: bgzf_file
    type: File
    secondaryFiles:
      - .gbi
    doc: bgzipped file with its grabix index (.gbi) beside it
    inputBinding:
      position: 1
  - id: number_of_lines
    type: int
    doc: number of random lines to extract
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Header plus the random lines
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grabix:0.1.8--h077b44d_12
stdout: grabix_random.out
