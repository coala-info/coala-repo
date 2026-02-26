cwlVersion: v1.2
class: CommandLineTool
baseCommand: mavis_summary
label: mavis_summary
doc: "Summarize MAVIS results.\n\nTool homepage: https://github.com/bcgsc/mavis.git"
inputs:
  - id: inputs
    type:
      type: array
      items: File
    doc: path to the input files
    inputBinding:
      position: 1
  - id: config
    type: File
    doc: path to the JSON config file
    inputBinding:
      position: 102
      prefix: --config
  - id: log
    type:
      - 'null'
      - File
    doc: redirect stdout to a log file
    default: None
    inputBinding:
      position: 102
      prefix: --log
  - id: log_level
    type:
      - 'null'
      - string
    doc: level of logging to output
    default: INFO
    inputBinding:
      position: 102
      prefix: --log_level
outputs:
  - id: output
    type: Directory
    doc: path to the output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mavis:3.1.2--pyhdfd78af_0
