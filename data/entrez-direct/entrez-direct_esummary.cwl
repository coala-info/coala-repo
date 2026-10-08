cwlVersion: v1.2
class: CommandLineTool
baseCommand: esummary
label: entrez-direct_esummary
doc: "Retrieves document summaries (DocSums) for Entrez records.\n\nTool homepage: https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README"
inputs:
  - id: edirect_in
    type:
      - 'null'
      - File
    doc: ENTREZ_DIRECT message from esearch or elink, read from standard input
  - id: mode
    type:
      - 'null'
      - string
    doc: xml, json
    inputBinding:
      position: 1
      prefix: -mode
  - id: db
    type:
      - 'null'
      - string
    doc: Database name
    inputBinding:
      position: 1
      prefix: -db
  - id: id
    type:
      - 'null'
      - type: array
        items: string
    doc: Unique identifier or accession number
    inputBinding:
      position: 1
      prefix: -id
      itemSeparator: ','
  - id: input
    type:
      - 'null'
      - File
    doc: Read identifier(s) from file instead of stdin
    inputBinding:
      position: 1
      prefix: -input
  - id: raw
    type:
      - 'null'
      - boolean
    doc: Skip database-specific XML modifications
    inputBinding:
      position: 1
      prefix: -raw
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/entrez-direct:24.0--he881be0_0
stdin: '$(inputs.edirect_in ? inputs.edirect_in.path : null)'
stdout: entrez-direct_esummary.out
