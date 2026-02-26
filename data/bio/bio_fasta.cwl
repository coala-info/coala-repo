cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio
label: bio_fasta
doc: "A tool for manipulating FASTA files.\n\nTool homepage: https://github.com/ialbert/bio"
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
    default: ''
    inputBinding:
      position: 102
      prefix: --end
  - id: features
    type:
      - 'null'
      - boolean
    doc: extract the fasta for the features
    inputBinding:
      position: 102
      prefix: --features
  - id: frame
    type:
      - 'null'
      - int
    doc: reading frame
    default: 1
    inputBinding:
      position: 102
      prefix: --frame
  - id: gene
    type:
      - 'null'
      - string
    doc: filter for a gene name
    default: ''
    inputBinding:
      position: 102
      prefix: --gene
  - id: id
    type:
      - 'null'
      - string
    doc: exact match on a sequence id
    default: ''
    inputBinding:
      position: 102
      prefix: --id
  - id: match
    type:
      - 'null'
      - string
    doc: regexp match on a sequence id
    default: ''
    inputBinding:
      position: 102
      prefix: --match
  - id: olap
    type:
      - 'null'
      - string
    doc: overlap with coordinate
    default: ''
    inputBinding:
      position: 102
      prefix: --olap
  - id: protein
    type:
      - 'null'
      - boolean
    doc: operate on the protein sequences
    inputBinding:
      position: 102
      prefix: --protein
  - id: rename
    type:
      - 'null'
      - string
    doc: rename sequence ids
    default: ''
    inputBinding:
      position: 102
      prefix: --rename
  - id: revcomp
    type:
      - 'null'
      - boolean
    doc: reverse complement DNA
    inputBinding:
      position: 102
      prefix: --revcomp
  - id: start
    type:
      - 'null'
      - int
    doc: start coordinate
    default: 1
    inputBinding:
      position: 102
      prefix: --start
  - id: translate
    type:
      - 'null'
      - boolean
    doc: translate DNA
    inputBinding:
      position: 102
      prefix: --translate
  - id: trim
    type:
      - 'null'
      - string
    doc: trim polyA tails (and leading/trailing Ns)
    default: ''
    inputBinding:
      position: 102
      prefix: --trim
  - id: type
    type:
      - 'null'
      - string
    doc: filter for a feature type
    default: ''
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
stdout: bio_fasta.out
