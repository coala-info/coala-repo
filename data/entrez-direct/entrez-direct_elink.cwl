cwlVersion: v1.2
class: CommandLineTool
baseCommand: elink
label: entrez-direct_elink
doc: "Finds links between records in different databases or within the same database.\n\
  \nTool homepage: https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README"
inputs:
  - id: edirect_in
    type:
      - 'null'
      - File
    doc: ENTREZ_DIRECT message from esearch or elink, read from standard input
  - id: cited
    type:
      - 'null'
      - boolean
    doc: References to this paper
    inputBinding:
      position: 101
      prefix: -cited
  - id: cites
    type:
      - 'null'
      - boolean
    doc: Publication reference list
    inputBinding:
      position: 101
      prefix: -cites
  - id: cmd
    type:
      - 'null'
      - string
    doc: Command type (edirect, uid, history, neighbor, score, acheck, ncheck, lcheck, llinks, llibs, prlinks)
    inputBinding:
      position: 101
      prefix: -cmd
  - id: db
    type:
      - 'null'
      - string
    doc: Database name
    inputBinding:
      position: 101
      prefix: -db
  - id: id
    type:
      - 'null'
      - type: array
        items: string
    doc: Unique identifier(s)
    inputBinding:
      position: 101
      prefix: -id
      itemSeparator: ','
  - id: input
    type:
      - 'null'
      - File
    doc: Read identifier(s) from file instead of stdin
    inputBinding:
      position: 101
      prefix: -input
  - id: log
    type:
      - 'null'
      - boolean
    doc: Log output to stderr
    inputBinding:
      position: 101
      prefix: -log
  - id: name
    type:
      - 'null'
      - string
    doc: Link name (e.g., pubmed_protein_refseq, pubmed_pubmed_citedin)
    inputBinding:
      position: 101
      prefix: -name
  - id: related
    type:
      - 'null'
      - boolean
    doc: Neighbors in same database
    inputBinding:
      position: 101
      prefix: -related
  - id: target
    type:
      - 'null'
      - string
    doc: Links in different database
    inputBinding:
      position: 101
      prefix: -target
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
stdout: entrez-direct_elink.out
