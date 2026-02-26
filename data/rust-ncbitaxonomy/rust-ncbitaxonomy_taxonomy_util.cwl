cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxonomy_util
label: rust-ncbitaxonomy_taxonomy_util
doc: "Utilities for working with the NCBI taxonomy database\n\nTool homepage: https://github.com/pvanheus/ncbitaxonomy"
inputs:
  - id: subcommand
    type:
      - 'null'
      - string
    doc: Subcommand to execute
    inputBinding:
      position: 1
  - id: db
    type: string
    doc: URL for SQLite taxonomy database
    inputBinding:
      position: 102
      prefix: --db
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-ncbitaxonomy:1.0.7--hf9427c6_6
stdout: rust-ncbitaxonomy_taxonomy_util.out
