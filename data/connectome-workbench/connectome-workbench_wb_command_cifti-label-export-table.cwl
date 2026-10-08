cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-label-export-table
label: connectome-workbench_wb_command_cifti-label-export-table
doc: "Takes the label table from the cifti label map, and writes it to a text format matching what is expected by -cifti-label-import.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: label_in
    type: File
    doc: the input cifti label file
    inputBinding:
      position: 1
  - id: map
    type: string
    doc: the number or name of the label map to use
    inputBinding:
      position: 2
  - id: table_out
    type: string
    doc: the output text file
    inputBinding:
      position: 3
outputs:
  - id: table_out_file
    type: File
    doc: the output text file
    outputBinding:
      glob: $(inputs.table_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
