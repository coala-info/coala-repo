cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/update_marker_file.R
label: garnett-cli_update_marker_file.R
doc: "Update marker gene list based on assessment file.\n\nTool homepage: https://github.com/ebi-gene-expression-group/garnett-cli"
inputs:
  - id: cell_type_col
    type:
      - 'null'
      - string
    doc: Marker gene assessment column name
    inputBinding:
      position: 101
      prefix: --cell-type-col
  - id: gene_id_col
    type:
      - 'null'
      - string
    doc: Gene id column name in marker assessment file
    inputBinding:
      position: 101
      prefix: --gene-id-col
  - id: marker_check_file
    type:
      - 'null'
      - File
    doc: Path to the file with marker gene assessment done by garnett
    inputBinding:
      position: 101
      prefix: --marker-check-file
  - id: marker_list_obj
    type:
      - 'null'
      - File
    doc: Path to the original marker gene list serialised object
    inputBinding:
      position: 101
      prefix: --marker-list-obj
  - id: summary_col
    type:
      - 'null'
      - string
    doc: Marker gene assessment column name
    inputBinding:
      position: 101
      prefix: --summary-col
outputs:
  - id: updated_marker_file
    type:
      - 'null'
      - File
    doc: Path to the updated marker file
    outputBinding:
      glob: $(inputs.updated_marker_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/garnett-cli:0.0.5--hdfd78af_1
