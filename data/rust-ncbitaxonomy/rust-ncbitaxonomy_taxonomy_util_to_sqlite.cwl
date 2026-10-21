cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxonomy_util
label: rust-ncbitaxonomy_taxonomy_util_to_sqlite
doc: "save taxonomy database loaded from files to SQLite database file\n\nTool homepage: https://github.com/pvanheus/ncbitaxonomy"
arguments:
  - position: 2
    valueFrom: to_sqlite
inputs:
  - id: db
    type: string
    doc: Output SQLite taxonomy database file name
    inputBinding:
      position: 1
      prefix: --db
  - id: tax_prefix
    type:
      - 'null'
      - string
    doc: String to prepend to names of nodes.dmp and names.dmp
    inputBinding:
      position: 3
      prefix: --tax_prefix
  - id: taxonomy_dir
    type: Directory
    doc: Directory containing the NCBI taxonomy nodes.dmp and names.dmp files
    inputBinding:
      position: 4
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: sqlite_db
    type: File
    doc: SQLite taxonomy database
    outputBinding:
      glob: $(inputs.db)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-ncbitaxonomy:1.0.7--hf9427c6_6
stdout: rust-ncbitaxonomy_taxonomy_util_to_sqlite.out
