cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-label-export-table
label: connectome-workbench_wb_command_volume-label-export-table
doc: "Takes the label table from the volume label map, and writes it to a text format matching what is expected by -volume-label-import.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: label_in
    type: File
    doc: "the input volume label file"
    inputBinding:
      position: 1
  - id: map
    type: string
    doc: "the number or name of the label map to use"
    inputBinding:
      position: 2
  - id: table_out
    type: string
    doc: "output - the output text file"
    inputBinding:
      position: 3
outputs:
  - id: label_table
    type: File
    doc: "the output text file"
    outputBinding:
      glob: $(inputs.table_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
