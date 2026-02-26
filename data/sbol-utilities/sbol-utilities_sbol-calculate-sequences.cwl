cwlVersion: v1.2
class: CommandLineTool
baseCommand: sbol-calculate-sequences
label: sbol-utilities_sbol-calculate-sequences
doc: "Calculates sequences for components in an SBOL file.\n\nTool homepage: https://github.com/SynBioDex/SBOL-utilities"
inputs:
  - id: sbol_file
    type: File
    doc: SBOL file used as input
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
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print running explanation of expansion process
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
