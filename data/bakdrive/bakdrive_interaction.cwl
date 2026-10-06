cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bakdrive
  - interaction
label: bakdrive_interaction
doc: "Performs interaction analysis based on taxonomic classification and metabolic
  models.\n\nTool homepage: https://gitlab.com/treangenlab/bakdrive"
inputs:
  - id: input_file
    type: File
    doc: Input file of a list of taxonomic classification file addresses
    inputBinding:
      position: 1
  - id: taxa_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in input_file. They are staged in the working directory, so
      input_file must list them by base name.
  - id: flag
    type:
      - 'null'
      - string
    doc: Calculate growth rate
    inputBinding:
      position: 102
      prefix: --flag
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
    doc: output folder
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.taxa_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bakdrive:1.0.4--hdfd78af_0
