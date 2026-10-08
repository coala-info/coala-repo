cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-gifti-label-to-roi'
label: connectome-workbench_wb_command_gifti-label-to-roi
doc: "Make a gifti label into an ROI metric. For each map in <label-in>, a map is created in <metric-out> where all locations labeled with <label-name> or with a key of <label-key> are given a value of 1, and all other locations are given 0. Exactly one of -name and -key must be specified.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: label_in
    type: File
    doc: the input gifti label file
    inputBinding:
      position: 1
  - id: metric_out
    type: string
    doc: output - the output metric file
    inputBinding:
      position: 2
  - id: name
    type:
      - 'null'
      - string
    doc: select label by name
    inputBinding:
      position: 3
      prefix: '-name'
  - id: key
    type:
      - 'null'
      - int
    doc: select label by key
    inputBinding:
      position: 3
      prefix: '-key'
  - id: map
    type:
      - 'null'
      - string
    doc: select a single label map to use (number or name)
    inputBinding:
      position: 3
      prefix: '-map'
outputs:
  - id: roi_metric
    type: File
    doc: the output metric file
    outputBinding:
      glob: $(inputs.metric_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
