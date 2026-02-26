cwlVersion: v1.2
class: CommandLineTool
baseCommand: commec_split
label: commec_split
doc: "Split a multi-record FASTA file into individual files, one for each record\n\
  \nTool homepage: https://github.com/ibbis-screening/common-mechanism"
inputs:
  - id: fasta_file
    type: File
    doc: Input fasta file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/commec:1.0.3--pyhdfd78af_0
stdout: commec_split.out
