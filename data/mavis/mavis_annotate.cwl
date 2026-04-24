cwlVersion: v1.2
class: CommandLineTool
baseCommand: mavis_annotate
label: mavis_annotate
doc: "Annotates variants with MAVIS.\n\nTool homepage: https://github.com/bcgsc/mavis.git"
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
outputs:
  - id: output
    type: Directory
    doc: path to the output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mavis:3.1.2--pyhdfd78af_0
