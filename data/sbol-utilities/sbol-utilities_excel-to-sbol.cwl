cwlVersion: v1.2
class: CommandLineTool
baseCommand: excel-to-sbol
label: sbol-utilities_excel-to-sbol
doc: "Converts an Excel file to SBOL format.\n\nTool homepage: https://github.com/SynBioDex/SBOL-utilities"
inputs:
  - id: excel_file
    type: File
    doc: Excel file used as input
    inputBinding:
      position: 1
  - id: file_type
    type:
      - 'null'
      - string
    doc: Name of SBOL file to output to (excluding type)
    inputBinding:
      position: 102
      prefix: --file-type
  - id: local
    type:
      - 'null'
      - string
    doc: Local path for Components in output file
    inputBinding:
      position: 102
      prefix: --local
  - id: namespace
    type:
      - 'null'
      - string
    doc: Namespace for Components in output file
    inputBinding:
      position: 102
      prefix: --namespace
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print running explanation of conversion process
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Name of SBOL file to be written
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sbol-utilities:1.0a16--pyhdfd78af_0
