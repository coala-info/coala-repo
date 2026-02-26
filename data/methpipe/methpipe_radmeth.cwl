cwlVersion: v1.2
class: CommandLineTool
baseCommand: radmeth
label: methpipe_radmeth
doc: "calculate differential methylation scores\n\nTool homepage: https://github.com/smithlabcode/methpipe"
inputs:
  - id: design_matrix
    type: File
    doc: Design matrix file
    inputBinding:
      position: 1
  - id: data_matrix
    type: File
    doc: Data matrix file
    inputBinding:
      position: 2
  - id: about
    type:
      - 'null'
      - boolean
    doc: print about message
    inputBinding:
      position: 103
      prefix: -about
  - id: factor
    type: string
    doc: a factor to test
    inputBinding:
      position: 103
      prefix: -factor
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print more run info
    inputBinding:
      position: 103
      prefix: -verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methpipe:5.0.1--h76b9af2_6
