cwlVersion: v1.2
class: CommandLineTool
baseCommand: terrace
label: terrace
doc: "TERRACE v1.1.2 (c) 2023 Tasfia Zahin, Qian Shi, Xiaofei Carl Zang, and Mingfu
  Shao, The Pennsylvania State University\n\nTool homepage: https://github.com/Shao-Group/TERRACE"
inputs:
  - id: bam_file
    type: File
    doc: bam-file.bam
    inputBinding:
      position: 101
      prefix: -i
  - id: feature_file
    type:
      - 'null'
      - File
    doc: feature_file
    inputBinding:
      position: 101
      prefix: -fe
  - id: library_type
    type:
      - 'null'
      - string
    doc: library type of the sample
    inputBinding:
      position: 101
      prefix: --library_type
  - id: read_length
    type: int
    doc: length of paired-end reads
    inputBinding:
      position: 101
      prefix: --read_length
  - id: reference_annotation
    type:
      - 'null'
      - File
    doc: reference_annotation.gtf
    inputBinding:
      position: 101
      prefix: -r
  - id: reference_genome
    type: File
    doc: reference-genome.fa
    inputBinding:
      position: 101
      prefix: -fa
outputs:
  - id: gtf_file
    type: File
    doc: gtf-file.gtf
    outputBinding:
      glob: $(inputs.gtf_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/terrace:1.1.2--he153687_0
