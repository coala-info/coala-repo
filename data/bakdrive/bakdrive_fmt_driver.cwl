cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bakdrive
  - fmt_driver
label: bakdrive_fmt_driver
doc: "Format driver species and their interactions for metabolic modeling.\n\nTool
  homepage: https://gitlab.com/treangenlab/bakdrive"
inputs:
  - id: input_file
    type: File
    doc: Input a list of disease sample file addresses
    inputBinding:
      position: 1
  - id: taxa_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in input_file. They are staged in the working directory, so
      input_file must list them by base name.
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
      - File
    doc: Input Driver Species (driver node list written by bakdrive driver)
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
      - Directory
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
  - id: output_path
    type: string
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output file folder
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.taxa_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bakdrive:1.0.4--hdfd78af_0
