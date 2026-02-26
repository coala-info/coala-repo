cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - abismal
  - idx
label: abismal_idx
doc: "build abismal index\n\nTool homepage: https://github.com/smithlabcode/abismal"
inputs:
  - id: genome_fasta
    type: File
    doc: genome fasta file
    inputBinding:
      position: 1
  - id: about
    type:
      - 'null'
      - boolean
    doc: print about message
    inputBinding:
      position: 102
      prefix: -about
  - id: targets
    type:
      - 'null'
      - string
    doc: target regions
    inputBinding:
      position: 102
      prefix: -targets
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 102
      prefix: -threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print more run info
    inputBinding:
      position: 102
      prefix: -verbose
outputs:
  - id: abismal_index_file
    type: File
    doc: abismal index file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abismal:3.3.0--h077b44d_0
