cwlVersion: v1.2
class: CommandLineTool
baseCommand: gndiff
label: gndiff
doc: "Extracts scientific names, their IDs and families from the query and reference\n\
  files, prints out a match of a query data to the reference data.\n\nThe files can
  be in comma-separated (CSV), tab-separated (TSV) formats, or\njust contain name-strings
  only (one per line).\n\nTSV/CSV files must contain 'ScientificName' field, 'Family'
  and 'TaxonID'\nfields are also ingested.\n\nTool homepage: https://github.com/gnames/gndiff"
inputs:
  - id: query_file
    type: File
    doc: Query file
    inputBinding:
      position: 1
  - id: reference_file
    type: File
    doc: Reference file
    inputBinding:
      position: 2
  - id: format
    type:
      - 'null'
      - string
    doc: "Sets output format. Can be one of: 'csv', 'tsv', 'compact', 'pretty'"
    inputBinding:
      position: 103
      prefix: --format
  - id: port
    type:
      - 'null'
      - int
    doc: Port to run web GUI.
    inputBinding:
      position: 103
      prefix: --port
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not output info and warning logs.
    inputBinding:
      position: 103
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gndiff:0.3.0--he881be0_1
stdout: gndiff.out
