cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-label-to-border'
label: connectome-workbench_wb_command_label-to-border
doc: "Draw borders around labels. For each label, finds all edges on the mesh that cross the boundary of the label, and draws borders through them, using the map name as the class name.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: surface
    type: File
    doc: the surface to use for neighbor information
    inputBinding:
      position: 1
  - id: label_in
    type: File
    doc: the input label file
    inputBinding:
      position: 2
  - id: border_out
    type: string
    doc: output - the output border file
    inputBinding:
      position: 3
  - id: placement
    type:
      - 'null'
      - float
    doc: fraction along edge from inside vertex to draw border points (default 0.33)
    inputBinding:
      position: 4
      prefix: '-placement'
  - id: column
    type:
      - 'null'
      - string
    doc: select a single column (number or name)
    inputBinding:
      position: 4
      prefix: '-column'
outputs:
  - id: border
    type: File
    doc: the output border file
    outputBinding:
      glob: $(inputs.border_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
