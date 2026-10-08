cwlVersion: v1.2
class: CommandLineTool
baseCommand: einfo
label: entrez-direct_einfo
doc: "Prints Entrez database names, field names and link names.\n\nTool homepage: https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README"
inputs:
  - id: dbs
    type:
      - 'null'
      - boolean
    doc: Print all database names
    inputBinding:
      position: 1
      prefix: -dbs
  - id: db
    type:
      - 'null'
      - string
    doc: Database name (or "all")
    inputBinding:
      position: 1
      prefix: -db
  - id: fields
    type:
      - 'null'
      - boolean
    doc: Print field names
    inputBinding:
      position: 2
      prefix: -fields
  - id: links
    type:
      - 'null'
      - boolean
    doc: Print link names
    inputBinding:
      position: 2
      prefix: -links
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/entrez-direct:24.0--he881be0_0
stdout: entrez-direct_einfo.out
