cwlVersion: v1.2
class: CommandLineTool
baseCommand: sdust
label: sdust
doc: "Symmetric DUST algorithm for identifying low-complexity regions in DNA sequences\n
  \nTool homepage: https://github.com/lh3/sdust"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: threshold
    type:
      - 'null'
      - int
    doc: Score threshold
    default: 20
    inputBinding:
      position: 102
      prefix: -t
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size
    default: 64
    inputBinding:
      position: 102
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sdust:0.1--h077b44d_2
stdout: sdust.out
