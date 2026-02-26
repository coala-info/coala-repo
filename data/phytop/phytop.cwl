cwlVersion: v1.2
class: CommandLineTool
baseCommand: phytop
label: phytop
doc: "phytop: error: the following arguments are required: NEWICK\n\nTool homepage:
  https://github.com/zhangrengang/phytop/"
inputs:
  - id: newick
    type: string
    doc: NEWICK
    inputBinding:
      position: 1
  - id: align
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: -align
  - id: alter_newick
    type:
      - 'null'
      - string
    doc: NEWICK
    inputBinding:
      position: 102
      prefix: -alter
  - id: astral_bin
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: -astral_bin
  - id: bl
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: -bl
  - id: branch_size
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: -branch_size
  - id: clades
    type:
      - 'null'
      - File
    inputBinding:
      position: 102
      prefix: -clades
  - id: collapse
    type:
      - 'null'
      - type: array
        items: string
    doc: TAXON/FILE
    inputBinding:
      position: 102
      prefix: -collapse
  - id: colors
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: -colors
  - id: cp
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: -cp
  - id: figfmt
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: -figfmt
  - id: figsize
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: -figsize
  - id: fontsize
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: -fontsize
  - id: g_newick
    type:
      - 'null'
      - string
    doc: NEWICK
    inputBinding:
      position: 102
      prefix: -g
  - id: leaf_size
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: -leaf_size
  - id: noshow
    type:
      - 'null'
      - type: array
        items: string
    doc: TAXON/FILE
    inputBinding:
      position: 102
      prefix: -noshow
  - id: notext
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: -notext
  - id: onshow
    type:
      - 'null'
      - type: array
        items: string
    doc: TAXON/FILE
    inputBinding:
      position: 102
      prefix: -onshow
  - id: outgroup
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: -outgroup
  - id: pie
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: -pie
  - id: pie_size
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: -pie_size
  - id: polytomy_test
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: -polytomy_test
  - id: pre
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: -pre
  - id: sort
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: -sort
  - id: subset
    type:
      - 'null'
      - type: array
        items: string
    doc: TAXON/FILE
    inputBinding:
      position: 102
      prefix: -subset
  - id: test
    type:
      - 'null'
      - type: array
        items: string
    doc: TAXON/FILE
    inputBinding:
      position: 102
      prefix: -test
  - id: tmp
    type:
      - 'null'
      - Directory
    inputBinding:
      position: 102
      prefix: -tmp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phytop:0.3--pyhdc42f0e_0
stdout: phytop.out
