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
      prefix: --annotation
  - id: create
    type:
      - 'null'
      - boolean
    doc: Create new database!
    inputBinding:
      position: 101
      prefix: --create
  - id: database
    type:
      - 'null'
      - File
      - string
    doc: CanSNPer2 database name (a string names a new database for --create; 
      an existing database File is staged writable so it can be modified)
    inputBinding:
      position: 101
      prefix: -db
      valueFrom: '$(self.class == "File" ? self.basename : self)'
  - id: debug
    type:
      - 'null'
      - boolean
    doc: print debug info
    inputBinding:
      position: 101
      prefix: --debug
  - id: export
    type:
      - 'null'
      - boolean
    doc: "Export database to text format (exports tree and\n                     annotation
      file)"
    inputBinding:
      position: 101
      prefix: --export
  - id: export_format
    type:
      - 'null'
      - string
    doc: Select output format [tab, newick]
    inputBinding:
      position: 101
      prefix: --export_format
  - id: logs
    type:
      - 'null'
      - string
    doc: Specify log directory
    inputBinding:
      position: 101
      prefix: --logs
  - id: mod_file
    type:
      - 'null'
      - File
    doc: File with modifications/update to the tree
    inputBinding:
      position: 101
      prefix: --mod_file
  - id: parent
    type:
      - 'null'
      - string
    doc: "Node (or nodes matching tree file) from which to\n                     update/replace/remove"
    inputBinding:
      position: 101
      prefix: --parent
  - id: references
    type:
      - 'null'
      - File
    doc: File containing all reference genomes listed
    inputBinding:
      position: 101
      prefix: --references
  - id: remove
    type:
      - 'null'
      - boolean
    doc: "If node is given, instead of replace/update remove branch\n            \
      \         from node"
    inputBinding:
      position: 101
      prefix: --remove
  - id: replace
    type:
      - 'null'
      - boolean
    doc: replace node
    inputBinding:
      position: 101
      prefix: --replace
  - id: source_type
    type:
      - 'null'
      - string
    doc: Select source file type
    inputBinding:
      position: 101
      prefix: --source_type
  - id: supress
    type:
      - 'null'
      - boolean
    doc: supress warnings
    inputBinding:
      position: 101
      prefix: --supress
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: Specify tmp directory default (/tmp)
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: tree
    type:
      - 'null'
      - File
    doc: CanSNPer tree source file
    inputBinding:
      position: 101
      prefix: --tree
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print process info, default no output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: outdir_path
    type:
      - 'null'
      - string
    doc: outdir for database export!
    inputBinding:
      position: 102
      prefix: --outdir
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: outdir for database export!
    outputBinding:
      glob: $(inputs.outdir_path)
  - id: database_out
    type:
      - 'null'
      - File
    doc: the created or modified database
    outputBinding:
      glob: '$(inputs.database == null ? [] : (inputs.database.class == "File" ? 
        inputs.database.basename : inputs.database))'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$(inputs.database != null && inputs.database.class == "File" ? 
          inputs.database : null)'
        writable: true
      - entry: '$(inputs.outdir_path == null ? null : {"class": "Directory", "basename":
          inputs.outdir_path, "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cansnper2:2.0.6--py_0
