cwlVersion: v1.2
class: CommandLineTool
baseCommand: esearch
label: entrez-direct_esearch
doc: "Query Specification\n\nTool homepage: https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README"
inputs:
  - id: component
    type:
      - 'null'
      - boolean
    doc: Individual term mapping items
    inputBinding:
      position: 101
      prefix: -component
  - id: database
    type:
      - 'null'
      - string
    doc: Database name
    inputBinding:
      position: 101
      prefix: -db
  - id: query
    type:
      - 'null'
      - string
    doc: Query string
    inputBinding:
      position: 101
      prefix: -query
  - id: sort
    type:
      - 'null'
      - string
    doc: Result presentation order
    inputBinding:
      position: 101
      prefix: -sort
  - id: spell
    type:
      - 'null'
      - boolean
    doc: Correct misspellings in query
    inputBinding:
      position: 101
      prefix: -spell
  - id: translate
    type:
      - 'null'
      - boolean
    doc: Show automatic term mapping
    inputBinding:
      position: 101
      prefix: -translate
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/entrez-direct:24.0--he881be0_0
stdout: entrez-direct_esearch.out
