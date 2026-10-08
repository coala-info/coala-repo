cwlVersion: v1.2
class: CommandLineTool
baseCommand: nquire
label: entrez-direct_nquire
doc: "Sends a query to a web service or an FTP site and prints the response.\n\
  \nThe command is one mode flag (for example -eutils, -get, -url, -pugrest,\n\
  -datasets, -litvar, -lst, -ftp, -dwn), then path words, then -key value pairs.\n\
  \nTool homepage: https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README"
inputs:
  - id: raw
    type:
      - 'null'
      - boolean
    doc: Skip special handling of the response (-raw)
    inputBinding:
      position: 1
      prefix: -raw
  - id: mode
    type: string
    doc: "Mode flag: -url, -get, -len, -lst, -dir, -ftp, -dwn, -asp, -ncbi, -eutils, -pubchem,\
      \ -pugrest, -pugview, -datasets, -litvar, -pathway, -gene-to-pathway,\
      \ -citmatch, -puglist, -pugwait"
    inputBinding:
      position: 2
  - id: path_words
    type:
      - 'null'
      - type: array
        items: string
    doc: Words after the mode flag, such as the URL, host, path parts, or the shortcut
      argument (for example esearch.fcgi, or compound name catechol cids TXT)
    inputBinding:
      position: 3
  - id: content_type
    type:
      - 'null'
      - string
    doc: Content type of the request (for example application/json)
    inputBinding:
      position: 4
      prefix: -content-type
  - id: query_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Query arguments as alternating -key value words (for example -db pubmed -term
      "tn3 transposition immunity")
    inputBinding:
      position: 5
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
stdout: entrez-direct_nquire.out
