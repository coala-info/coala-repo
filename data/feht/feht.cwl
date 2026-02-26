cwlVersion: v1.2
class: CommandLineTool
baseCommand: feht
label: feht
doc: "Predictive marker discovery for groups; binary data, genomic data (single nucleotide
  variants), and arbitrary character data.\n\nTool homepage: https://github.com/chadlaing/feht/"
inputs:
  - id: correction
    type:
      - 'null'
      - string
    doc: Multiple-testing correction to apply
    default: bonferroni
    inputBinding:
      position: 101
      prefix: --correction
  - id: data_file
    type: File
    doc: File of binary or single-nucleotide variant data
    inputBinding:
      position: 101
      prefix: --datafile
  - id: delimiter
    type:
      - 'null'
      - type: array
        items: string
    doc: Delimiter used for both the metadata and data file
    default: \t
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: group1
    type:
      - 'null'
      - string
    doc: Group1 column name, followed by optional Group1 labels to include as 
      part of the group
    inputBinding:
      position: 101
      prefix: --one
  - id: group2
    type:
      - 'null'
      - string
    doc: Group2 column name, followed by optional Group2 labels to include as 
      part of the group
    inputBinding:
      position: 101
      prefix: --two
  - id: info_file
    type: File
    doc: File of metadata information
    inputBinding:
      position: 101
      prefix: --infoFile
  - id: mode
    type:
      - 'null'
      - string
    doc: Mode for program data; either 'binary' or 'snp'
    default: binary
    inputBinding:
      position: 101
      prefix: --mode
  - id: ratio_filter
    type:
      - 'null'
      - float
    doc: Filter results by ratio (0.00-1.00)
    default: 0.0
    inputBinding:
      position: 101
      prefix: --ratioFilter
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/feht:1.1.0--0
stdout: feht.out
