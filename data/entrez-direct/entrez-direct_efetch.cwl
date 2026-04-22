cwlVersion: v1.2
class: CommandLineTool
baseCommand: efetch
label: entrez-direct_efetch
doc: "Fetch records from NCBI databases.\n\nTool homepage: https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README"
inputs:
  - id: chr_start
    type:
      - 'null'
      - int
    doc: Sequence range from 0-based coordinates
    inputBinding:
      position: 101
      prefix: -chr_start
  - id: chr_stop
    type:
      - 'null'
      - int
    doc: Sequence range from 0-based coordinates in gene docsum GenomicInfoType 
      object
    inputBinding:
      position: 101
      prefix: -chr_stop
  - id: complexity
    type:
      - 'null'
      - int
    doc: 0 = default, 1 = bioseq, 3 = nuc-prot set
    inputBinding:
      position: 101
      prefix: -complexity
  - id: db
    type: string
    doc: Database name
    inputBinding:
      position: 101
      prefix: -db
  - id: express
    type:
      - 'null'
      - boolean
    doc: Direct sequence retrieval in groups of 5
    inputBinding:
      position: 101
      prefix: -express
  - id: extend
    type:
      - 'null'
      - boolean
    doc: Extend sequence retrieval in both directions
    inputBinding:
      position: 101
      prefix: -extend
  - id: extrafeat
    type:
      - 'null'
      - int
    doc: Bit flag specifying extra features
    inputBinding:
      position: 101
      prefix: -extrafeat
  - id: format
    type:
      - 'null'
      - string
    doc: Format of record or report
    inputBinding:
      position: 101
      prefix: -format
  - id: forward
    type:
      - 'null'
      - boolean
    doc: Force strand 1
    inputBinding:
      position: 101
      prefix: -forward
  - id: id
    type:
      - 'null'
      - type: array
        items: string
    doc: Unique identifier or accession number
    inputBinding:
      position: 101
      prefix: -id
  - id: immediate
    type:
      - 'null'
      - boolean
    doc: Express mode on a single record at a time
    inputBinding:
      position: 101
      prefix: -immediate
  - id: input
    type:
      - 'null'
      - File
    doc: Read identifier(s) from file instead of stdin
    inputBinding:
      position: 101
      prefix: -input
  - id: mode
    type:
      - 'null'
      - string
    doc: text, xml, asn, binary, json
    inputBinding:
      position: 101
      prefix: -mode
  - id: raw
    type:
      - 'null'
      - boolean
    doc: Skip database-specific XML modifications
    inputBinding:
      position: 101
      prefix: -raw
  - id: revcomp
    type:
      - 'null'
      - boolean
    doc: Force strand 2
    inputBinding:
      position: 101
      prefix: -revcomp
  - id: seq_start
    type:
      - 'null'
      - int
    doc: First sequence position to retrieve
    inputBinding:
      position: 101
      prefix: -seq_start
  - id: seq_stop
    type:
      - 'null'
      - int
    doc: Last sequence position to retrieve
    inputBinding:
      position: 101
      prefix: -seq_stop
  - id: showgaps
    type:
      - 'null'
      - boolean
    doc: Propagate component gaps
    inputBinding:
      position: 101
      prefix: -showgaps
  - id: start
    type:
      - 'null'
      - int
    doc: First record to fetch
    inputBinding:
      position: 101
      prefix: -start
  - id: stop
    type:
      - 'null'
      - int
    doc: Last record to fetch
    inputBinding:
      position: 101
      prefix: -stop
  - id: strand
    type:
      - 'null'
      - int
    doc: 1 = forward DNA strand, 2 = reverse complement (otherwise strand minus 
      is set if start > stop)
    inputBinding:
      position: 101
      prefix: -strand
  - id: style
    type:
      - 'null'
      - string
    doc: master, conwithfeat
    inputBinding:
      position: 101
      prefix: -style
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/entrez-direct:24.0--he881be0_0
  - class: NetworkAccess
    networkAccess: true
stdout: entrez-direct_efetch.out
