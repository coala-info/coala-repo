cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -metric-rois-to-border
label: connectome-workbench_wb_command_metric-rois-to-border
doc: 'For each ROI column, finds all edges on the mesh that cross the boundary of
  the ROI, and draws borders through them. By default, this is done on all columns
  in the input file, using the map name as the name for the border.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: surface
    type: File
    doc: the surface to use for neighbor information
    inputBinding:
      position: 1
  - id: metric
    type: File
    doc: the input metric containing ROIs
    inputBinding:
      position: 2
  - id: class_name
    type: string
    doc: the name to use for the class of the output borders
    inputBinding:
      position: 3
  - id: border_out
    type: string
    doc: output - the output border file
    inputBinding:
      position: 4
  - id: placement
    type:
      - 'null'
      - float
    doc: set how far along the edge border points are drawn
    inputBinding:
      position: 5
      prefix: -placement
  - id: column
    type:
      - 'null'
      - string
    doc: select a single column
    inputBinding:
      position: 5
      prefix: -column
outputs:
  - id: border_out_file
    type: File
    doc: the output border file
    outputBinding:
      glob: $(inputs.border_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
