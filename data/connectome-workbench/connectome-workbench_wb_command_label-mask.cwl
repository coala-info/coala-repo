cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-label-mask'
label: connectome-workbench_wb_command_label-mask
doc: "Mask a label file. The output label is a copy of the input label, but with the 'unused' label wherever the mask metric is zero or negative. With -column, the output contains only the masked version of that column.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: label
    type: File
    doc: the label file to mask
    inputBinding:
      position: 1
  - id: mask
    type: File
    doc: the mask metric
    inputBinding:
      position: 2
  - id: label_out
    type: string
    doc: output - the output label file
    inputBinding:
      position: 3
  - id: column
    type:
      - 'null'
      - string
    doc: select a single column (number or name)
    inputBinding:
      position: 4
      prefix: '-column'
outputs:
  - id: masked_label
    type: File
    doc: the output label file
    outputBinding:
      glob: $(inputs.label_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
