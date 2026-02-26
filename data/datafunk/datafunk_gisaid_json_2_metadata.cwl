cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datafunk
  - gisaid_json_2_metadata
label: datafunk_gisaid_json_2_metadata
doc: "Add the info from a Gisaid json dump to an existing metadata table (or create
  a new one)\n\nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: gisaid_json
    type: File
    doc: Most recent Gisaid json dump
    inputBinding:
      position: 101
      prefix: --new
  - id: lineages_csv
    type:
      - 'null'
      - File
    doc: csv file of ineages to include
    inputBinding:
      position: 101
      prefix: --lineages
  - id: old_metadata_csv
    type: string
    doc: Last metadata table (csv format), or 'False' if you really want (but 
      you will lose date stamp information from previous dumps)
    inputBinding:
      position: 101
      prefix: --csv
  - id: omissions_files
    type:
      type: array
      items: File
    doc: A file that contains (anywhere) EPI_ISL_###### IDs to exclude (can 
      provide more than one file, e.g. -e FILE1 -e FILE2 ...)
    inputBinding:
      position: 101
      prefix: --exclude
outputs:
  - id: new_metadata_csv
    type: File
    doc: New csv file to write
    outputBinding:
      glob: $(inputs.new_metadata_csv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
