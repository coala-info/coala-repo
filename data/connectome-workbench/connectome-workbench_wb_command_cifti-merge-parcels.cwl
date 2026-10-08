cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-merge-parcels
label: connectome-workbench_wb_command_cifti-merge-parcels
doc: "The input cifti files must have matching mappings along the direction not specified, and the mapping along the specified direction must be parcels. The direction can be either an integer starting from 1, or the strings 'ROW' or 'COLUMN'.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: direction
    type: string
    doc: which dimension to merge along (integer, 'ROW', or 'COLUMN')
    inputBinding:
      position: 1
  - id: cifti_out
    type: string
    doc: the output cifti file
    inputBinding:
      position: 2
  - id: cifti
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -cifti
    doc: 'specify an input cifti file: a cifti file to merge (repeatable)'
    inputBinding:
      position: 3
outputs:
  - id: cifti_out_file
    type: File
    doc: the output cifti file
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
