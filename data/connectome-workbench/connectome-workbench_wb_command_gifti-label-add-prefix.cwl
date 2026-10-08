cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-gifti-label-add-prefix'
label: connectome-workbench_wb_command_gifti-label-add-prefix
doc: "Add a prefix to all label names in a gifti label file. For each label other than '???', prepend <prefix> to the label name.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: label_in
    type: File
    doc: the input label file
    inputBinding:
      position: 1
  - id: prefix
    type: string
    doc: the prefix string to add
    inputBinding:
      position: 2
  - id: label_out
    type: string
    doc: output - the output label file
    inputBinding:
      position: 3
outputs:
  - id: prefixed_label
    type: File
    doc: the output label file
    outputBinding:
      glob: $(inputs.label_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
