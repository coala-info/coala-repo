cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-cifti-roi-average'
label: connectome-workbench_wb_command_cifti-roi-average
doc: "Average rows in a single cifti file. Average the rows that are within the specified ROIs, and write the resulting average row to a text file, separated by newlines. If -cifti-roi is specified, -left-roi, -right-roi, -cerebellum-roi, and -vol-roi must not be specified.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: cifti_in
    type: File
    doc: the cifti file to average rows from
    inputBinding:
      position: 1
  - id: text_out
    type: string
    doc: output text file of the average values
    inputBinding:
      position: 2
  - id: cifti_roi
    type:
      - 'null'
      - File
    doc: cifti file containing combined rois
    inputBinding:
      position: 10
      prefix: '-cifti-roi'
  - id: left_roi
    type:
      - 'null'
      - File
    doc: vertices to use from left hemisphere, as a metric file
    inputBinding:
      position: 11
      prefix: '-left-roi'
  - id: right_roi
    type:
      - 'null'
      - File
    doc: vertices to use from right hemisphere, as a metric file
    inputBinding:
      position: 12
      prefix: '-right-roi'
  - id: cerebellum_roi
    type:
      - 'null'
      - File
    doc: vertices to use from cerebellum, as a metric file
    inputBinding:
      position: 13
      prefix: '-cerebellum-roi'
  - id: vol_roi
    type:
      - 'null'
      - File
    doc: voxels to use, as a volume file
    inputBinding:
      position: 14
      prefix: '-vol-roi'
outputs:
  - id: average_text
    type: File
    doc: text file of the average values
    outputBinding:
      glob: $(inputs.text_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
