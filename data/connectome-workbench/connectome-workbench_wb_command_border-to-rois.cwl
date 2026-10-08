cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -border-to-rois
label: connectome-workbench_wb_command_border-to-rois
doc: "By default, draws ROIs inside all borders in the border file, as separate metric columns.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
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
  - id: inverse
    type:
      - 'null'
      - boolean
    doc: use inverse selection (outside border)
    inputBinding:
      position: 5
      prefix: -inverse
  - id: include_border
    type:
      - 'null'
      - boolean
    doc: include vertices the border is closest to
    inputBinding:
      position: 6
      prefix: -include-border
outputs:
  - id: metric_out_file
    type: File
    doc: the output metric file
    outputBinding:
      glob: $(inputs.metric_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
