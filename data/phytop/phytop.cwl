cwlVersion: v1.2
class: CommandLineTool
baseCommand: phytop
label: phytop
doc: "Visualizing ILS/IH signals on species tree from ASTRAL.\n\nTool homepage:
  https://github.com/zhangrengang/phytop/"
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: QT_QPA_PLATFORM
        envValue: offscreen
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.newick)
        writable: true
inputs:
  - id: newick
    type: File
    doc: Species tree output by ASTRAL (using option `-u 2` for C++ versions and
      `-t 2` for JAVA versions). Staged writable because outputs are written
      beside it.
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: alter_newick
    type:
      - 'null'
      - File
    doc: Show the tree (e.g. a timetree) instead of the ASTRAL tree (their topologies MUST be identical)
    inputBinding:
      position: 102
      prefix: -alter
  - id: genetrees
    type:
      - 'null'
      - File
    doc: Gene trees for branch lengths in TEST mode
    inputBinding:
      position: 102
      prefix: -g
  - id: align
    type:
      - 'null'
      - boolean
    doc: Align tips
    inputBinding:
      position: 102
      prefix: -align
  - id: concordance_percent
    type:
      - 'null'
      - boolean
    doc: Show gene-species trees concordance percent at inner nodes instead of PP
    inputBinding:
      position: 102
      prefix: -cp
  - id: branch_size
    type:
      - 'null'
      - int
    doc: Font size of text in branch [default=48]
    inputBinding:
      position: 102
      prefix: -branch_size
  - id: leaf_size
    type:
      - 'null'
      - int
    doc: Font size of leaf name [default=60]
    inputBinding:
      position: 102
      prefix: -leaf_size
  - id: sort
    type:
      - 'null'
      - boolean
    doc: Sort q1, q2 and q3, which will miss the directionality
    inputBinding:
      position: 102
      prefix: -sort
  - id: notext
    type:
      - 'null'
      - boolean
    doc: Do not draw text on the barcharts
    inputBinding:
      position: 102
      prefix: -notext
  - id: figsize
    type:
      - 'null'
      - float
    doc: Figure size of barcharts [default=3]
    inputBinding:
      position: 102
      prefix: -figsize
  - id: fontsize
    type:
      - 'null'
      - int
    doc: Font size of text in barcharts [default=13]
    inputBinding:
      position: 102
      prefix: -fontsize
  - id: figfmt
    type:
      - 'null'
      - string
    doc: Figure format of barcharts in tmpdir [default=png]
    inputBinding:
      position: 102
      prefix: -figfmt
  - id: colors
    type:
      - 'null'
      - string
    doc: Set colors for barcharts/piecharts
    inputBinding:
      position: 102
      prefix: -colors
  - id: polytomy_test
    type:
      - 'null'
      - boolean
    doc: Test for polytomies
    inputBinding:
      position: 102
      prefix: -polytomy_test
  - id: pie
    type:
      - 'null'
      - boolean
    doc: Use piechart instead of barchart
    inputBinding:
      position: 102
      prefix: -pie
  - id: pie_size
    type:
      - 'null'
      - int
    doc: Size of Piecharts [default=30]
    inputBinding:
      position: 102
      prefix: -pie_size
  - id: bl
    type:
      - 'null'
      - boolean
    doc: Branch lengths to check
    inputBinding:
      position: 102
      prefix: -bl
  - id: test
    type:
      - 'null'
      - type: array
        items: string
    doc: Test four-taxon (the first is outgroup and others are sampled for three ingroups); TAXON/FILE list
    inputBinding:
      position: 102
      prefix: -test
  - id: astral_bin
    type:
      - 'null'
      - string
    doc: ASTRAL command ('astral-pro', 'astral-hybrid', ...) [default=astral-pro]
    inputBinding:
      position: 102
      prefix: -astral_bin
  - id: outgroup
    type:
      - 'null'
      - string
    doc: "Outgroup [default: the first of `-test`]"
    inputBinding:
      position: 102
      prefix: -outgroup
  - id: clades
    type:
      - 'null'
      - File
    doc: Definition of clades
    inputBinding:
      position: 102
      prefix: -clades
  - id: collapse
    type:
      - 'null'
      - type: array
        items: string
    doc: Collapse clades; TAXON/FILE list
    inputBinding:
      position: 102
      prefix: -collapse
  - id: onshow
    type:
      - 'null'
      - type: array
        items: string
    doc: Only show charts on these inner nodes; TAXON/FILE list
    inputBinding:
      position: 102
      prefix: -onshow
  - id: noshow
    type:
      - 'null'
      - type: array
        items: string
    doc: Do not show charts on these inner nodes; TAXON/FILE list
    inputBinding:
      position: 102
      prefix: -noshow
  - id: subset
    type:
      - 'null'
      - type: array
        items: string
    doc: Show a subset clade with their MRCA; TAXON/FILE list
    inputBinding:
      position: 102
      prefix: -subset
  - id: pre
    type:
      - 'null'
      - string
    doc: Prefix for output
    inputBinding:
      position: 102
      prefix: -pre
  - id: tmp
    type:
      - 'null'
      - string
    doc: Temporary directory [default=tmp]
    inputBinding:
      position: 102
      prefix: -tmp
outputs:
  - id: pdf
    type:
      - 'null'
      - type: array
        items: File
    doc: Tree figures (PDF)
    outputBinding:
      glob: '*.pdf'
  - id: info_tsv
    type:
      - 'null'
      - type: array
        items: File
    doc: The value of each node (*.info.tsv) and other result tables
    outputBinding:
      glob: '*.tsv'
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phytop:0.3--pyhdc42f0e_0
stdout: phytop.out
