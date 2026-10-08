cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-gifti-all-labels-to-rois'
label: connectome-workbench_wb_command_gifti-all-labels-to-rois
doc: "Make ROIs from all labels in a gifti column. The output metric file has a column for each label in the specified input map, other than the ??? label, each of which contains an ROI of all vertices that are set to the corresponding label.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: label_in
    type: File
    doc: the input gifti label file
    inputBinding:
      position: 1
  - id: map
    type: string
    doc: the number or name of the label map to use
    inputBinding:
      position: 2
  - id: metric_out
    type: string
    doc: output - the output metric file
    inputBinding:
      position: 3
outputs:
  - id: roi_metric
    type: File
    doc: the output metric file
    outputBinding:
      glob: $(inputs.metric_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
