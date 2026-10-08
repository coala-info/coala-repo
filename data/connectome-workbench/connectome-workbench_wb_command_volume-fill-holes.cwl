cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-fill-holes
label: connectome-workbench_wb_command_volume-fill-holes
doc: "Finds all face-connected parts that are not included in the ROI, and fills all but the largest one with ones.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: volume_in
    type: File
    doc: "the input ROI volume"
    inputBinding:
      position: 1
  - id: volume_out
    type: string
    doc: "output - the output ROI volume"
    inputBinding:
      position: 2
outputs:
  - id: output_volume
    type: File
    doc: "the output ROI volume"
    outputBinding:
      glob: $(inputs.volume_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
