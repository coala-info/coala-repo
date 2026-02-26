cwlVersion: v1.2
class: CommandLineTool
baseCommand: elink
label: entrez-direct_elink
doc: "Finds links between records in different databases or within the same database.\n\
  \nTool homepage: https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README"
inputs:
  - id: acheck
    type:
      - 'null'
      - boolean
    doc: All links available
    inputBinding:
      position: 101
      prefix: acheck
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
    doc: Command type
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
  - id: edirect
    type:
      - 'null'
      - boolean
    doc: Instantiate results in ENTREZ_DIRECT message
    inputBinding:
      position: 101
      prefix: edirect
  - id: history
    type:
      - 'null'
      - boolean
    doc: Save results in Entrez history server
    inputBinding:
      position: 101
      prefix: history
  - id: id
    type:
      - 'null'
      - type: array
        items: string
    doc: Unique identifier(s)
    inputBinding:
      position: 101
      prefix: -id
  - id: input
    type:
      - 'null'
      - File
    doc: Read identifier(s) from file instead of stdin
    inputBinding:
      position: 101
      prefix: -input
  - id: lcheck
    type:
      - 'null'
      - boolean
    doc: Existence of external links (LinkOuts)
    inputBinding:
      position: 101
      prefix: lcheck
  - id: llibs
    type:
      - 'null'
      - boolean
    doc: All LinkOut providers
    inputBinding:
      position: 101
      prefix: llibs
  - id: llinks
    type:
      - 'null'
      - boolean
    doc: Non-library LinkOut providers
    inputBinding:
      position: 101
      prefix: llinks
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
  - id: ncheck
    type:
      - 'null'
      - boolean
    doc: Existence of neighbors
    inputBinding:
      position: 101
      prefix: ncheck
  - id: neighbor
    type:
      - 'null'
      - boolean
    doc: Neighbors or links
    inputBinding:
      position: 101
      prefix: neighbor
  - id: prlinks
    type:
      - 'null'
      - boolean
    doc: Primary LinkOut provider
    inputBinding:
      position: 101
      prefix: prlinks
  - id: related
    type:
      - 'null'
      - boolean
    doc: Neighbors in same database
    inputBinding:
      position: 101
      prefix: -related
  - id: score
    type:
      - 'null'
      - boolean
    doc: Neighbors with computed similarity scores
    inputBinding:
      position: 101
      prefix: score
  - id: target
    type:
      - 'null'
      - boolean
    doc: Links in different database
    inputBinding:
      position: 101
      prefix: -target
  - id: uid
    type:
      - 'null'
      - boolean
    doc: Return results as sorted and uniqued UID list
    inputBinding:
      position: 101
      prefix: uid
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/entrez-direct:24.0--he881be0_0
stdout: entrez-direct_elink.out
