cwlVersion: v1.2
class: CommandLineTool
baseCommand: sqt_randomseq
label: sqt_randomseq
doc: "Generate random sequences in FASTA format\n\nTool homepage: https://github.com/tdjsnelling/sqtracker"
inputs:
  - id: n
    type: int
    doc: Number of sequences to generate
    inputBinding:
      position: 1
  - id: maximum_length
    type:
      - 'null'
      - int
    inputBinding:
      position: 102
      prefix: --maximum-length
  - id: minimum_length
    type:
      - 'null'
      - int
    inputBinding:
      position: 102
      prefix: --minimum-length
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sqt:v0.8.0-3-deb-py3_cv1
stdout: sqt_randomseq.out
