cwlVersion: v1.2
class: CommandLineTool
baseCommand: sbol-expand-derivations
label: sbol-utilities_sbol-expand-derivations
doc: "Expand derivations in an SBOL file.\n\nTool homepage: https://github.com/SynBioDex/SBOL-utilities"
inputs:
  - id: input_file
    type: File
    doc: SBOL file used as input
    inputBinding:
      position: 1
  - id: expansion_target
    type:
      - 'null'
      - type: array
        items: string
    doc: Name of object to be expanded; can be used multiple times. If not 
      listed, will attempt to expand all root derivations
    inputBinding:
      position: 102
      prefix: --expansion-target
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
