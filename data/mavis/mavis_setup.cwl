cwlVersion: v1.2
class: CommandLineTool
baseCommand: mavis_setup
label: mavis_setup
doc: "Setup Mavis\n\nTool homepage: https://github.com/bcgsc/mavis.git"
inputs:
  - id: config
    type: File
    doc: path to the JSON config file
    inputBinding:
      position: 101
      prefix: --config
  - id: log
    type:
      - 'null'
      - File
    doc: redirect stdout to a log file
    inputBinding:
      position: 101
      prefix: --log
  - id: log_level
    type:
      - 'null'
      - string
    doc: level of logging to output
    inputBinding:
      position: 101
      prefix: --log_level
outputs:
  - id: outputfile
    type: File
    doc: path to the outputfile
    outputBinding:
      glob: $(inputs.outputfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mavis:3.1.2--pyhdfd78af_0
