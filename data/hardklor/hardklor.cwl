cwlVersion: v1.2
class: CommandLineTool
baseCommand: hardklor
label: hardklor
doc: "Hardklor is a tool for processing mass spectrometry data.\n\nTool homepage:
  https://github.com/mhoopmann/hardklor"
inputs:
  - id: config_file
    type: File
    doc: Configuration file for Hardklor
    inputBinding:
      position: 1
  - id: input_file
    type: File
    doc: Input file for Hardklor
    inputBinding:
      position: 2
  - id: cmd
    type:
      - 'null'
      - boolean
    doc: Execute Hardklor in command mode
    inputBinding:
      position: 103
      prefix: -cmd
outputs:
  - id: output_file
    type: File
    doc: Output file for Hardklor
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hardklor:2.3.2--h503566f_6
