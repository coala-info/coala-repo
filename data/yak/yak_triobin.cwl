cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yak
  - triobin
label: yak_triobin
doc: "Identify and extract triobins from yak files.\n\nTool homepage: https://github.com/lh3/yak"
inputs:
  - id: pat_yak
    type: File
    doc: Path to the pattern yak file.
    inputBinding:
      position: 1
  - id: mat_yak
    type: File
    doc: Path to the matrix yak file.
    inputBinding:
      position: 2
  - id: seq_fa
    type: File
    doc: Path to the sequence FASTA file.
    inputBinding:
      position: 3
  - id: mid_occurrence
    type:
      - 'null'
      - int
    doc: Mid occurrence count for a triobin.
    inputBinding:
      position: 104
      prefix: -d
  - id: min_occurrence
    type:
      - 'null'
      - int
    doc: Minimum occurrence count for a triobin.
    inputBinding:
      position: 104
      prefix: -c
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 104
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yak:0.1--hed695b0_0
stdout: yak_triobin.out
