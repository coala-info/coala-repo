cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gqt
  - fst
label: gqt_fst
doc: "Calculate Fst between populations.\n\nTool homepage: https://github.com/ryanlayer/gqt"
inputs:
  - id: gqt_file
    type: File
    doc: gqt file
    inputBinding:
      position: 101
      prefix: -i
  - id: label_db_field_name
    type:
      - 'null'
      - string
    doc: label db field name (requried for pca-shared)
    inputBinding:
      position: 101
      prefix: -f
  - id: label_output_file
    type:
      - 'null'
      - File
    doc: label output file (requried for pca-shared)
    inputBinding:
      position: 101
      prefix: -l
  - id: ped_database_file
    type: File
    doc: ped database file
    inputBinding:
      position: 101
      prefix: -d
  - id: population_query
    type:
      type: array
      items: string
    doc: Each population query defines one subpopulation.
    inputBinding:
      position: 101
      prefix: -p
  - id: tmp_directory
    type:
      - 'null'
      - Directory
    doc: tmp direcory name for remote files
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gqt:1.1.3--h0263287_3
stdout: gqt_fst.out
