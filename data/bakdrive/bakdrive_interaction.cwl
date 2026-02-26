cwlVersion: v1.2
class: CommandLineTool
baseCommand: bakdrive_interaction
label: bakdrive_interaction
doc: "Performs interaction analysis based on taxonomic classification and metabolic
  models.\n\nTool homepage: https://gitlab.com/treangenlab/bakdrive"
inputs:
  - id: input_file
    type: File
    doc: Input file of a list of taxonomic classification file addresses
    inputBinding:
      position: 1
  - id: flag
    type:
      - 'null'
      - boolean
    doc: Calculate growth rate
    default: true
    inputBinding:
      position: 102
      prefix: --flag
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
      - Directory
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
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: output folder
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bakdrive:1.0.4--hdfd78af_0
