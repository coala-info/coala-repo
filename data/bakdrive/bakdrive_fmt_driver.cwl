cwlVersion: v1.2
class: CommandLineTool
baseCommand: bakdrive_fmt_driver
label: bakdrive_fmt_driver
doc: "Format driver species and their interactions for metabolic modeling.\n\nTool
  homepage: https://gitlab.com/treangenlab/bakdrive"
inputs:
  - id: input_file
    type: File
    doc: Input a list of disease sample file addresses
    inputBinding:
      position: 1
  - id: amount
    type:
      - 'null'
      - string
    doc: Input amount of driver species
    inputBinding:
      position: 102
      prefix: --amount
  - id: driver
    type:
      - 'null'
      - string
    doc: Input Driver Species
    inputBinding:
      position: 102
      prefix: --driver
  - id: medium
    type:
      - 'null'
      - File
    doc: Medium CSV file
    inputBinding:
      position: 102
      prefix: --medium
  - id: model
    type:
      - 'null'
      - string
    doc: Metabolic model database
    inputBinding:
      position: 102
      prefix: --model
  - id: percentage
    type:
      - 'null'
      - float
    doc: Percentage of species removed
    inputBinding:
      position: 102
      prefix: --percentage
  - id: strength
    type:
      - 'null'
      - float
    doc: Threshold of Interaction Strength
    inputBinding:
      position: 102
      prefix: --strength
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output file folder
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bakdrive:1.0.4--hdfd78af_0
