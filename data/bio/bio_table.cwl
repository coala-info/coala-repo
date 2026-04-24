cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio
label: bio_table
doc: "Generates tabular output from data.\n\nTool homepage: https://github.com/ialbert/bio"
inputs:
  - id: fnames
    type:
      - 'null'
      - type: array
        items: File
    doc: input files
    inputBinding:
      position: 1
  - id: end
    type:
      - 'null'
      - string
    doc: end coordinate
    inputBinding:
      position: 102
      prefix: --end
  - id: fields
    type:
      - 'null'
      - string
    doc: table fields
    inputBinding:
      position: 102
      prefix: --fields
  - id: gene
    type:
      - 'null'
      - string
    doc: filter for a gene name
    inputBinding:
      position: 102
      prefix: --gene
  - id: id
    type:
      - 'null'
      - string
    doc: exact match on a sequence id
    inputBinding:
      position: 102
      prefix: --id
  - id: match
    type:
      - 'null'
      - string
    doc: regexp match on a sequence id
    inputBinding:
      position: 102
      prefix: --match
  - id: olap
    type:
      - 'null'
      - string
    doc: overlap with coordinate
    inputBinding:
      position: 102
      prefix: --olap
  - id: rename
    type:
      - 'null'
      - string
    doc: rename sequence ids
    inputBinding:
      position: 102
      prefix: --rename
  - id: start
    type:
      - 'null'
      - int
    doc: start coordinate
    inputBinding:
      position: 102
      prefix: --start
  - id: type
    type:
      - 'null'
      - string
    doc: filter for a feature type
    inputBinding:
      position: 102
      prefix: --type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
stdout: bio_table.out
