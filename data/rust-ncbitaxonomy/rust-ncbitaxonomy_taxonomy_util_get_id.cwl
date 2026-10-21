cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxonomy_util
label: rust-ncbitaxonomy_taxonomy_util_get_id
doc: "find taxonomy ID for name\n\nTool homepage: https://github.com/pvanheus/ncbitaxonomy"
arguments:
  - position: 2
    valueFrom: get_id
inputs:
  - id: db
    type: File
    doc: SQLite taxonomy database (made with taxonomy_util to_sqlite)
    inputBinding:
      position: 1
      prefix: --db
  - id: name
    type: string
    doc: Name of taxon
    inputBinding:
      position: 4
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-ncbitaxonomy:1.0.7--hf9427c6_6
stdout: rust-ncbitaxonomy_taxonomy_util_get_id.out
