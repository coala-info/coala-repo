cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-all-labels-to-rois
label: connectome-workbench_wb_command_volume-all-labels-to-rois
doc: "The output volume has a frame for each label in the specified input frame, other than the ??? label, each of which contains an ROI of all voxels that are set to the corresponding label.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: label_in
    type: File
    doc: "the input volume label file"
    inputBinding:
      position: 1
  - id: map
    type: string
    doc: "the number or name of the label map to use"
    inputBinding:
      position: 2
  - id: volume_out
    type: string
    doc: "output - the output volume file"
    inputBinding:
      position: 3
outputs:
  - id: output_volume
    type: File
    doc: "the output volume file"
    outputBinding:
      glob: $(inputs.volume_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
