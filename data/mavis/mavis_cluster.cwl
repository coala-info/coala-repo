cwlVersion: v1.2
class: CommandLineTool
baseCommand: mavis_cluster
label: mavis_cluster
doc: "Cluster MAVIS results\n\nTool homepage: https://github.com/bcgsc/mavis.git"
inputs:
  - id: inputs
    type:
      type: array
      items: File
    doc: path to the input files
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - File
    doc: path to the JSON config file
    inputBinding:
      position: 102
      prefix: --config
  - id: library
    type: string
    doc: The library to run the current step on
    inputBinding:
      position: 102
      prefix: --library
  - id: log
    type:
      - 'null'
      - File
    doc: redirect stdout to a log file
    inputBinding:
      position: 102
      prefix: --log
  - id: log_level
    type:
      - 'null'
      - string
    doc: level of logging to output
    inputBinding:
      position: 102
      prefix: --log_level
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type: Directory
    doc: path to the output directory
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mavis:3.1.2--pyhdfd78af_0
