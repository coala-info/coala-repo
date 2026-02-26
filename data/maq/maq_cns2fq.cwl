cwlVersion: v1.2
class: CommandLineTool
baseCommand: maq_cns2fq
label: maq_cns2fq
doc: "Convert consensus sequence to FASTQ format.\n\nTool homepage: https://github.com/maqetta/maqetta"
inputs:
  - id: input_cns
    type: File
    doc: Input consensus sequence file (.cns)
    inputBinding:
      position: 1
  - id: max_read_depth
    type:
      - 'null'
      - int
    doc: maximum read depth
    default: 255
    inputBinding:
      position: 102
      prefix: -D
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: minimum mapping quality
    default: 40
    inputBinding:
      position: 102
      prefix: -Q
  - id: min_neighbouring_quality
    type:
      - 'null'
      - int
    doc: minimum neighbouring quality
    default: 20
    inputBinding:
      position: 102
      prefix: -n
  - id: min_read_depth
    type:
      - 'null'
      - int
    doc: minimum read depth
    default: 3
    inputBinding:
      position: 102
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
stdout: maq_cns2fq.out
