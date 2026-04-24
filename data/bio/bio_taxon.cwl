cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio
label: bio_taxon
doc: "Taxonomic ID lookup and database management tool.\n\nTool homepage: https://github.com/ialbert/bio"
inputs:
  - id: terms
    type:
      - 'null'
      - type: array
        items: string
    doc: Taxids or search queries
    inputBinding:
      position: 1
  - id: accessions
    type:
      - 'null'
      - boolean
    doc: Print the accessions number for each
    inputBinding:
      position: 102
      prefix: --accessions
  - id: build
    type:
      - 'null'
      - boolean
    doc: updates and builds a local database
    inputBinding:
      position: 102
      prefix: --build
  - id: depth
    type:
      - 'null'
      - int
    doc: how deep to visit a clade
    inputBinding:
      position: 102
      prefix: --depth
  - id: field
    type:
      - 'null'
      - int
    doc: which column to read when filtering
    inputBinding:
      position: 102
      prefix: --field
  - id: indent
    type:
      - 'null'
      - int
    doc: the indentation depth (set to zero for flat)
    inputBinding:
      position: 102
      prefix: --indent
  - id: keep
    type:
      - 'null'
      - string
    doc: clade to keep
    inputBinding:
      position: 102
      prefix: --keep
  - id: lineage
    type:
      - 'null'
      - boolean
    doc: show the lineage for a taxon term
    inputBinding:
      position: 102
      prefix: --lineage
  - id: list
    type:
      - 'null'
      - boolean
    doc: lists database content
    inputBinding:
      position: 102
      prefix: --list
  - id: preload
    type:
      - 'null'
      - boolean
    doc: loads entire database in memory
    inputBinding:
      position: 102
      prefix: --preload
  - id: remove
    type:
      - 'null'
      - string
    doc: clade to remove
    inputBinding:
      position: 102
      prefix: --remove
  - id: sep
    type:
      - 'null'
      - string
    doc: separator (default is ', ')
    inputBinding:
      position: 102
      prefix: --sep
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode, prints more messages
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
stdout: bio_taxon.out
