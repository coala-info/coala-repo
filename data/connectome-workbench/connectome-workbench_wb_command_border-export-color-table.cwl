cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -border-export-color-table
label: connectome-workbench_wb_command_border-export-color-table
doc: "Takes the names and colors of each border, and writes it to the same format as -metric-label-import expects. By default, the borders are colored by border name, specify -class-colors to color them by class instead. The key values start at 1 and follow the order of the borders in the file.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: border_file
    type: File
    doc: the input border file
    inputBinding:
      position: 1
  - id: table_out
    type: string
    doc: the output text file
    inputBinding:
      position: 2
  - id: class_colors
    type:
      - 'null'
      - boolean
    doc: use class colors instead of the name colors
    inputBinding:
      position: 3
      prefix: -class-colors
outputs:
  - id: table_out_file
    type: File
    doc: the output text file
    outputBinding:
      glob: $(inputs.table_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
