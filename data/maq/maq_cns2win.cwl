cwlVersion: v1.2
class: CommandLineTool
baseCommand: maq cns2win
label: maq_cns2win
doc: "Convert consensus sequences to windowed format.\n\nTool homepage: https://github.com/maqetta/maqetta"
inputs:
  - id: input_cns
    type: File
    doc: Input consensus sequence file
    inputBinding:
      position: 1
  - id: consensus_type
    type:
      - 'null'
      - string
    doc: Consensus type
    inputBinding:
      position: 102
      prefix: -c
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality
    inputBinding:
      position: 102
      prefix: -b
  - id: min_error_rate
    type:
      - 'null'
      - int
    doc: Minimum error rate
    inputBinding:
      position: 102
      prefix: -e
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    inputBinding:
      position: 102
      prefix: -q
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size
    inputBinding:
      position: 102
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
stdout: maq_cns2win.out
