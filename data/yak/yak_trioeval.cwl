cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yak
  - trioeval
label: yak_trioeval
doc: "Evaluate trios from yak files and a reference FASTA.\n\nTool homepage: https://github.com/lh3/yak"
inputs:
  - id: pat_yak
    type: File
    doc: Path to the paternal yak file
    inputBinding:
      position: 1
  - id: mat_yak
    type: File
    doc: Path to the maternal yak file
    inputBinding:
      position: 2
  - id: seq_fa
    type: File
    doc: Path to the reference FASTA file
    inputBinding:
      position: 3
  - id: mid_occurrence
    type:
      - 'null'
      - int
    doc: mid occurrence
    inputBinding:
      position: 104
      prefix: -d
  - id: min_occurrence
    type:
      - 'null'
      - int
    doc: min occurrence
    inputBinding:
      position: 104
      prefix: -c
  - id: min_streak
    type:
      - 'null'
      - int
    doc: min streak
    inputBinding:
      position: 104
      prefix: -n
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
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
stdout: yak_trioeval.out
