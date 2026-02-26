cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedIntersect
label: ucsc-bedintersect
doc: "Find overlaps between two bed files.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: file_a
    type: File
    doc: First BED file (A)
    inputBinding:
      position: 1
  - id: file_b
    type: File
    doc: Second BED file (B)
    inputBinding:
      position: 2
  - id: only_a
    type:
      - 'null'
      - boolean
    doc: Only output items in A that overlap with B
    inputBinding:
      position: 103
      prefix: -a
  - id: only_b
    type:
      - 'null'
      - boolean
    doc: Only output items in B that overlap with A
    inputBinding:
      position: 103
      prefix: -b
  - id: unique
    type:
      - 'null'
      - boolean
    doc: Unique - only output each item once
    inputBinding:
      position: 103
      prefix: -u
outputs:
  - id: output_file
    type: File
    doc: Output file for results
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedintersect:482--h0b57e2e_0
