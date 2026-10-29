cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metagenomics.py
  - krona
label: viral-ngs_metagenomics_krona
doc: "Create an interactive HTML report from a tabular metagenomic report\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_tsv
    type: File
    doc: "Input tab delimited file."
    inputBinding:
      position: 1
  - id: db
    type: Directory
    doc: "Krona taxonomy database directory."
    inputBinding:
      position: 2
  - id: out_html
    type: string
    doc: "Output html report."
    inputBinding:
      position: 3
  - id: query_column
    type:
      - 'null'
      - int
    doc: "Column of query id. (default 2)"
    inputBinding:
      position: 20
      prefix: --queryColumn
  - id: taxid_column
    type:
      - 'null'
      - int
    doc: "Column of taxonomy id. (default 3)"
    inputBinding:
      position: 20
      prefix: --taxidColumn
  - id: score_column
    type:
      - 'null'
      - int
    doc: "Column of score. (default None)"
    inputBinding:
      position: 20
      prefix: --scoreColumn
  - id: no_hits
    type:
      - 'null'
      - boolean
    doc: "Include wedge for no hits."
    inputBinding:
      position: 20
      prefix: --noHits
  - id: no_rank
    type:
      - 'null'
      - boolean
    doc: "Include no rank assignments."
    inputBinding:
      position: 20
      prefix: --noRank
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
outputs:
  - id: out_html_file
    type: File
    doc: "Output file written to out_html"
    outputBinding:
      glob: $(inputs.out_html)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
