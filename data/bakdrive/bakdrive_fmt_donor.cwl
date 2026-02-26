cwlVersion: v1.2
class: CommandLineTool
baseCommand: bakdrive fmt_donor
label: bakdrive_fmt_donor
doc: "Input disease and donor sample file addresses\n\nTool homepage: https://gitlab.com/treangenlab/bakdrive"
inputs:
  - id: input_file
    type: File
    doc: Input disease and donor sample file addresses
    inputBinding:
      position: 1
  - id: medium
    type:
      - 'null'
      - File
    doc: Medium CSV file
    default: medium.csv
    inputBinding:
      position: 102
      prefix: --medium
  - id: model
    type:
      - 'null'
      - string
    doc: Metabolic model database
    default: dbs
    inputBinding:
      position: 102
      prefix: --model
  - id: percentage
    type:
      - 'null'
      - float
    doc: Percentage of species removed
    default: 0.1
    inputBinding:
      position: 102
      prefix: --percentage
  - id: strength
    type:
      - 'null'
      - float
    doc: Threshold of interaction strength
    default: 0.2
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
