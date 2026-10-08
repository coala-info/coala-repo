cwlVersion: v1.2
class: CommandLineTool
baseCommand: epost
label: entrez-direct_epost
doc: "Uploads unique identifiers or sequence accession numbers to the Entrez history server and prints an ENTREZ_DIRECT message.\n\nTool homepage: https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README"
inputs:
  - id: db
    type: string
    doc: Database name
    inputBinding:
      position: 1
      prefix: -db
  - id: id
    type:
      - 'null'
      - type: array
        items: string
    doc: Unique identifier(s) or accession number(s)
    inputBinding:
      position: 1
      prefix: -id
      itemSeparator: ','
  - id: format
    type:
      - 'null'
      - string
    doc: uid or acc
    inputBinding:
      position: 1
      prefix: -format
  - id: input
    type:
      - 'null'
      - File
    doc: Read identifier(s) from file instead of stdin
    inputBinding:
      position: 1
      prefix: -input
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
stdout: entrez-direct_epost.out
