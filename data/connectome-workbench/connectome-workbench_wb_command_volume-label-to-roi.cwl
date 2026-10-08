cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-label-to-roi
label: connectome-workbench_wb_command_volume-label-to-roi
doc: "For each map in <label-in>, a map is created in <volume-out> where all locations labeled with <label-name> or with a key of <label-key> are given a value of 1, and all other locations are given 0. Exactly one of -name and -key must be specified. Specify -map to use only one map from <label-in>.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: label_in
    type: File
    doc: "the input volume label file"
    inputBinding:
      position: 1
  - id: volume_out
    type: string
    doc: "output - the output volume file"
    inputBinding:
      position: 2
  - id: label_name
    type:
      - 'null'
      - string
    doc: "select label by name: the label name that you want an roi of"
    inputBinding:
      position: 3
      prefix: -name
  - id: label_key
    type:
      - 'null'
      - int
    doc: "select label by key: the label key that you want an roi of"
    inputBinding:
      position: 4
      prefix: -key
  - id: map
    type:
      - 'null'
      - string
    doc: "select a single label map to use: the map number or name"
    inputBinding:
      position: 5
      prefix: -map
outputs:
  - id: output_volume
    type: File
    doc: "the output volume file"
    outputBinding:
      glob: $(inputs.volume_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
