cwlVersion: v1.2
class: CommandLineTool
baseCommand: scvis_map
label: scvis_map
doc: "Map new data to a pretrained scvis model.\n\nTool homepage: https://bitbucket.org/jerry00/scvis-dev/commits/all"
inputs:
  - id: config_file
    type:
      - 'null'
      - File
    doc: Path to a yaml format configuration file
    inputBinding:
      position: 101
      prefix: --config_file
  - id: data_label_file
    type:
      - 'null'
      - File
    doc: Just used for colouring scatter plots
    inputBinding:
      position: 101
      prefix: --data_label_file
  - id: data_matrix_file
    type: File
    doc: The high-dimensional data matrix
    inputBinding:
      position: 101
      prefix: --data_matrix_file
  - id: normalize
    type:
      - 'null'
      - float
    doc: Data will be divided by this number if provided
    inputBinding:
      position: 101
      prefix: --normalize
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Path for output files
    inputBinding:
      position: 101
      prefix: --out_dir
  - id: pretrained_model_file
    type: File
    doc: A pretrained scvis model used to map new data
    inputBinding:
      position: 101
      prefix: --pretrained_model_file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scvis:0.1.0--scvis_0
stdout: scvis_map.out
