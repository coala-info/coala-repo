cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-all-labels-to-rois
label: connectome-workbench_wb_command_cifti-all-labels-to-rois
doc: "The output cifti file is a dscalar file with a column (map) for each label in the specified input map, other than the ??? label, each of which contains a binary ROI of all brainordinates that are set to the corresponding label. Most of the time, specifying '1' for the <map> argument will do what is desired.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: label_in
    type: File
    doc: the input cifti label file
    inputBinding:
      position: 1
  - id: map
    type: string
    doc: the number or name of the label map to use
    inputBinding:
      position: 2
  - id: cifti_out
    type: string
    doc: the output cifti file
    inputBinding:
      position: 3
outputs:
  - id: cifti_out_file
    type: File
    doc: the output cifti file
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
