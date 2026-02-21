cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraclu
label: paraclu
doc: "A tool for finding clusters in data (typically used for transcription start
  site clustering), requiring a minimum value threshold and an input file.\n\nTool
  homepage: http://cbrc3.cbrc.jp/~martin/paraclu/"
inputs:
  - id: min_value
    type: int
    doc: The minimum value threshold for clustering
    inputBinding:
      position: 1
  - id: input_file
    type: File
    doc: The input data file to be processed
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paraclu:10--h077b44d_6
stdout: paraclu.out
