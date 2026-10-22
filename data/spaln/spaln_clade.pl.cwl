cwlVersion: v1.2
class: CommandLineTool
baseCommand: clade.pl
label: spaln_clade.pl
doc: "clade.pl: make clades from .dvn/.dvp pairwise score files.\n\nTool homepage: https://github.com/ogotoh/spaln"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Debug output"
    inputBinding:
      position: 10
      prefix: -D
      separate: false
  - id: threshold
    type:
      - 'null'
      - int
    doc: "Threshold on the score in the first column (default 100); glued to -H"
    inputBinding:
      position: 10
      prefix: -H
      separate: false
  - id: avoid
    type:
      - 'null'
      - string
    doc: "Pattern: members matching it are kept out of the master role; glued to -A"
    inputBinding:
      position: 10
      prefix: -A
      separate: false
  - id: slave_only
    type:
      - 'null'
      - boolean
    doc: "Slave only, don't output master"
    inputBinding:
      position: 10
      prefix: -M
      separate: false
  - id: master_only
    type:
      - 'null'
      - boolean
    doc: "Master only, don't output slave"
    inputBinding:
      position: 10
      prefix: -S
      separate: false
  - id: no_unique
    type:
      - 'null'
      - boolean
    doc: "Don't output unique members"
    inputBinding:
      position: 10
      prefix: -U
      separate: false
  - id: resemblance
    type:
      - 'null'
      - boolean
    doc: "Resemblance: the score is a similarity, not a distance"
    inputBinding:
      position: 10
      prefix: -R
      separate: false
  - id: input_files
    type:
      type: array
      items: File
    doc: "Pairwise score files (.dvn/.dvp or spaln AvsA -O0 output); score first, the two sequence names last"
    inputBinding:
      position: 200
outputs:
  - id: clades
    type: stdout
    doc: One clade per line (stdout)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spaln:3.0.7--pl5321h077b44d_1
stdout: spaln_clade.out
