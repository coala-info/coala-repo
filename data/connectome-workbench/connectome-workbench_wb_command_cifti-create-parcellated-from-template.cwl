cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-create-parcellated-from-template
label: connectome-workbench_wb_command_cifti-create-parcellated-from-template
doc: "For each parcel name in the template mapping, find that name in an input cifti file and use its data in the output file. All input cifti files must have a parcels mapping along <modify-direction> and matching mappings along other dimensions. The direction can be either an integer starting from 1, or the strings 'ROW' or 'COLUMN'.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: cifti_template
    type: File
    doc: a cifti file with the template parcel mapping along column
    inputBinding:
      position: 1
  - id: modify_direction
    type: string
    doc: which dimension of the output file should match the template (integer, 'ROW', or 'COLUMN')
    inputBinding:
      position: 2
  - id: cifti_out
    type: string
    doc: the output cifti file
    inputBinding:
      position: 3
  - id: fill_value
    type:
      - 'null'
      - float
    doc: 'specify value to be used in parcels that don''t match: value to use (default 0)'
    inputBinding:
      position: 4
      prefix: -fill-value
  - id: cifti
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -cifti
    doc: 'specify an input cifti file: the input parcellated cifti file (repeatable)'
    inputBinding:
      position: 5
outputs:
  - id: cifti_out_file
    type: File
    doc: the output cifti file
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
