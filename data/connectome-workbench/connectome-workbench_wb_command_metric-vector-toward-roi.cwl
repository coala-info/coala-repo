cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -metric-vector-toward-roi
label: connectome-workbench_wb_command_metric-vector-toward-roi
doc: 'At each vertex, compute the vector along the start of the shortest path to the
  ROI.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: surface
    type: File
    doc: the surface to compute on
    inputBinding:
      position: 1
  - id: target_roi
    type: File
    doc: the roi to find the shortest path to
    inputBinding:
      position: 2
  - id: metric_out
    type: string
    doc: output - the output metric
    inputBinding:
      position: 3
  - id: roi
    type:
      - 'null'
      - File
    doc: don't compute for vertices outside an roi
    inputBinding:
      position: 4
      prefix: -roi
outputs:
  - id: metric_out_file
    type: File
    doc: the output metric
    outputBinding:
      glob: $(inputs.metric_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
