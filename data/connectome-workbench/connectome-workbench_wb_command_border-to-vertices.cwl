cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -border-to-vertices
label: connectome-workbench_wb_command_border-to-vertices
doc: "Outputs a metric with 1s on vertices that follow a border, and 0s elsewhere. By default, a separate metric column is created for each border.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: surface
    type: File
    doc: the surface the borders are drawn on
    inputBinding:
      position: 1
  - id: border_file
    type: File
    doc: the border file
    inputBinding:
      position: 2
  - id: metric_out
    type: string
    doc: the output metric file
    inputBinding:
      position: 3
  - id: border
    type:
      - 'null'
      - string
    doc: 'create ROI for only one border: the name of the border'
    inputBinding:
      position: 4
      prefix: -border
outputs:
  - id: metric_out_file
    type: File
    doc: the output metric file
    outputBinding:
      glob: $(inputs.metric_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
