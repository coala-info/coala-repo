cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio
label: bio_format
doc: "Parses and processes biological sequence files.\n\nTool homepage: https://github.com/ialbert/bio"
inputs:
  - id: fnames
    type:
      - 'null'
      - type: array
        items: File
    doc: Input file names
    inputBinding:
      position: 1
  - id: diff
    type:
      - 'null'
      - boolean
    doc: output differences
    inputBinding:
      position: 102
      prefix: --diff
  - id: end
    type:
      - 'null'
      - string
    doc: end coordinate
    default: ''
    inputBinding:
      position: 102
      prefix: --end
  - id: paired
    type:
      - 'null'
      - boolean
    doc: fasta input is pairwise
    inputBinding:
      position: 102
      prefix: --paired
  - id: start
    type:
      - 'null'
      - string
    doc: start coordinate
    default: ''
    inputBinding:
      position: 102
      prefix: --start
  - id: table
    type:
      - 'null'
      - boolean
    doc: output in tabular format
    inputBinding:
      position: 102
      prefix: --table
  - id: vcf
    type:
      - 'null'
      - boolean
    doc: output vcf
    inputBinding:
      position: 102
      prefix: --vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
stdout: bio_format.out
