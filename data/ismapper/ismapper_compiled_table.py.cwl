cwlVersion: v1.2
class: CommandLineTool
baseCommand: compiled_table.py
label: ismapper_compiled_table.py
doc: "Create a table of IS hits in all isolates for ISMapper\n\nTool homepage: https://github.com/jhawkey/IS_mapper/"
inputs:
  - id: cds
    type:
      - 'null'
      - string
    doc: qualifier containing gene information (default product). Also note that
      all CDS features MUST have a locus_tag
    default: product
    inputBinding:
      position: 101
      prefix: --cds
  - id: gap
    type:
      - 'null'
      - int
    doc: distance between regions to call overlapping, default is 0
    default: 0
    inputBinding:
      position: 101
      prefix: --gap
  - id: imprecise
    type:
      - 'null'
      - float
    doc: Binary value for imprecise (*) hit (can be 1, 0 or 0.5), default is 1
    default: 1
    inputBinding:
      position: 101
      prefix: --imprecise
  - id: out_prefix
    type: string
    doc: Prefix for output file
    inputBinding:
      position: 101
      prefix: --out_prefix
  - id: query
    type: File
    doc: fasta file for insertion sequence query for compilation
    inputBinding:
      position: 101
      prefix: --query
  - id: reference
    type: File
    doc: gbk file of reference
    inputBinding:
      position: 101
      prefix: --reference
  - id: rrna
    type:
      - 'null'
      - string
    doc: qualifier containing gene information (default product). Also note that
      all rRNA features MUST have a locus_tag
    default: product
    inputBinding:
      position: 101
      prefix: --rrna
  - id: tables
    type:
      type: array
      items: string
    doc: tables to compile
    inputBinding:
      position: 101
      prefix: --tables
  - id: trna
    type:
      - 'null'
      - string
    doc: qualifier containing gene information (default product). Also note that
      all tRNA features MUST have a locus_tag
    default: product
    inputBinding:
      position: 101
      prefix: --trna
  - id: unconfident
    type:
      - 'null'
      - float
    doc: Binary value for questionable (?) hit (can be 1, 0 or 0.5), default is 
      0
    default: 0
    inputBinding:
      position: 101
      prefix: --unconfident
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ismapper:2.0.2--pyhdfd78af_1
stdout: ismapper_compiled_table.py.out
