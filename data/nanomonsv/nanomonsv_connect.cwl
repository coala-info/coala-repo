cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanomonsv_connect
label: nanomonsv_connect
doc: "Connects SVs from different reads based on their positions and support.\n\n\
  Tool homepage: https://github.com/friend1ws/nanomonsv"
inputs:
  - id: nanomonsv_result_file
    type: File
    doc: Path to nanomonsv get result file
    inputBinding:
      position: 1
  - id: support_read_file
    type: File
    doc: PATH to support read file
    inputBinding:
      position: 2
  - id: output_prefix
    type: string
    doc: Prefix of output files
    inputBinding:
      position: 3
  - id: consistent_pos_margin
    type:
      - 'null'
      - float
    doc: Consistency coefficient of distances of read and reference between two 
      SVs
    inputBinding:
      position: 104
      prefix: --consistent_pos_margin
  - id: debug
    type:
      - 'null'
      - boolean
    doc: keep intermediate files
    inputBinding:
      position: 104
      prefix: --debug
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanomonsv:0.8.1--pyhdfd78af_0
stdout: nanomonsv_connect.out
