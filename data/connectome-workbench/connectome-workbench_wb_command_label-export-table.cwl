cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-label-export-table'
label: connectome-workbench_wb_command_label-export-table
doc: "Export the label table from a gifti label file as text, in the format expected by -metric-label-import.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: label_in
    type: File
    doc: the input label file
    inputBinding:
      position: 1
  - id: table_out
    type: string
    doc: output - the output text file
    inputBinding:
      position: 2
outputs:
  - id: label_table
    type: File
    doc: the output text file
    outputBinding:
      glob: $(inputs.table_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
