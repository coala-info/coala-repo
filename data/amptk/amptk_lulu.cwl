cwlVersion: v1.2
class: CommandLineTool
baseCommand: amptk-lulu.py
label: amptk_lulu
doc: "Script runs OTU table post processing LULU to identify low abundance error OTUs\n\
  \nTool homepage: https://github.com/nextgenusfs/amptk"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Remove Intermediate Files
    inputBinding:
      position: 101
      prefix: --debug
  - id: fasta
    type: File
    doc: Input OTUs (multi-fasta)
    inputBinding:
      position: 101
      prefix: --fasta
  - id: min_match
    type:
      - 'null'
      - int
    doc: LULU minimum match percent identity
    inputBinding:
      position: 101
      prefix: --min_match
  - id: min_ratio
    type:
      - 'null'
      - float
    doc: LULU minimum ratio
    inputBinding:
      position: 101
      prefix: --min_ratio
  - id: min_ratio_type
    type:
      - 'null'
      - string
    doc: LULU minimum ratio threshold
    inputBinding:
      position: 101
      prefix: --min_ratio_type
  - id: min_relative_cooccurence
    type:
      - 'null'
      - int
    doc: LULU minimum relative cooccurance
    inputBinding:
      position: 101
      prefix: --min_relative_cooccurence
  - id: otu_table
    type: File
    doc: Input OTU table
    inputBinding:
      position: 101
      prefix: --otu_table
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: Output folder basename
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
