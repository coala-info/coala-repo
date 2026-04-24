cwlVersion: v1.2
class: CommandLineTool
baseCommand: CanSNPer2-database
label: cansnper2_CanSNPer2-database
doc: "CanSNPer2-database\n\nTool homepage: https://github.com/FOI-Bioinformatics/CanSNPer2"
inputs:
  - id: annotation
    type:
      - 'null'
      - File
    doc: CanSNPer snp source file
    inputBinding:
      position: 101
  - id: create
    type:
      - 'null'
      - boolean
    doc: Create new database!
    inputBinding:
      position: 101
  - id: database
    type: string
    doc: CanSNPer2 database name
    inputBinding:
      position: 101
      prefix: -db
  - id: debug
    type:
      - 'null'
      - boolean
    doc: print debug info
    inputBinding:
      position: 101
  - id: export
    type:
      - 'null'
      - boolean
    doc: "Export database to text format (exports tree and\n                     annotation
      file)"
    inputBinding:
      position: 101
  - id: export_format
    type:
      - 'null'
      - string
    doc: Select output format [tab, newick]
    inputBinding:
      position: 101
  - id: logs
    type:
      - 'null'
      - Directory
    doc: Specify log directory
    inputBinding:
      position: 101
  - id: mod_file
    type:
      - 'null'
      - File
    doc: File with modifications/update to the tree
    inputBinding:
      position: 101
  - id: parent
    type:
      - 'null'
      - string
    doc: "Node (or nodes matching tree file) from which to\n                     update/replace/remove"
    inputBinding:
      position: 101
  - id: references
    type:
      - 'null'
      - File
    doc: File containing all reference genomes listed
    inputBinding:
      position: 101
  - id: remove
    type:
      - 'null'
      - boolean
    doc: "If node is given, instead of replace/update remove branch\n            \
      \         from node"
    inputBinding:
      position: 101
  - id: replace
    type:
      - 'null'
      - boolean
    doc: replace node
    inputBinding:
      position: 101
  - id: source_type
    type:
      - 'null'
      - string
    doc: Select source file type
    inputBinding:
      position: 101
  - id: supress
    type:
      - 'null'
      - boolean
    doc: supress warnings
    inputBinding:
      position: 101
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Specify tmp directory default (/tmp)
    inputBinding:
      position: 101
  - id: tree
    type:
      - 'null'
      - File
    doc: CanSNPer tree source file
    inputBinding:
      position: 101
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print process info, default no output
    inputBinding:
      position: 101
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: outdir for database export!
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cansnper2:2.0.6--py_0
