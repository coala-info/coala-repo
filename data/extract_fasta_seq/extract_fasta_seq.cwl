cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq
label: extract_fasta_seq
doc: "Print numbers from FIRST to LAST, in steps of INC. FIRST, INC default to 1.\n\
  \nTool homepage: https://github.com/linzhi2013/extract_fasta_seq"
inputs:
  - id: first
    type:
      - 'null'
      - int
    doc: Starting number
    inputBinding:
      position: 1
  - id: inc
    type:
      - 'null'
      - int
    doc: Increment step
    inputBinding:
      position: 2
  - id: last
    type: int
    doc: Ending number
    inputBinding:
      position: 3
  - id: pad_zeros
    type:
      - 'null'
      - boolean
    doc: Pad to last with leading zeros
    inputBinding:
      position: 104
      prefix: -w
  - id: separator
    type:
      - 'null'
      - string
    doc: String separator
    inputBinding:
      position: 104
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/extract-codon-alignment:0.0.1--py_0
stdout: extract_fasta_seq.out
