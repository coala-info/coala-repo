cwlVersion: v1.2
class: CommandLineTool
baseCommand: arb_ntree
label: arb-bio_arb
doc: "Main ARB database and phylogeny tool for starting ARB, merging databases, or
  importing files.\n\nTool homepage: http://www.arb-home.de"
inputs:
  - id: db1
    type:
      - 'null'
      - File
    doc: Primary database file (.arb), directory, or filemask. If used alone, starts
      ARB with this DB. If used with a second DB, acts as the source for merging.
    inputBinding:
      position: 1
  - id: db2
    type:
      - 'null'
      - File
    doc: Target database file for merging from DB1.
    inputBinding:
      position: 2
  - id: execute
    type:
      - 'null'
      - string
    doc: Execute macro 'macroname' after startup
    inputBinding:
      position: 103
      prefix: --execute
  - id: import
    type:
      - 'null'
      - File
    doc: Import FILE into new database (FILE may be a filemask)
    inputBinding:
      position: 103
      prefix: --import
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arb-bio:6.0.6--0
stdout: arb-bio_arb.out
