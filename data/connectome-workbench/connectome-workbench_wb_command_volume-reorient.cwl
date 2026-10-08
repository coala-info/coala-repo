cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-reorient
label: connectome-workbench_wb_command_volume-reorient
doc: "Changes the voxel order and the header spacing/origin information such that the value of any spatial point is unchanged. Orientation strings look like 'LPI', which means first index is left to right, second is posterior to anterior, and third is inferior to superior.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: volume
    type: File
    doc: "the volume to reorient"
    inputBinding:
      position: 1
  - id: orient_string
    type: string
    doc: "the desired orientation, e.g. 'LPI'"
    inputBinding:
      position: 2
  - id: volume_out
    type: string
    doc: "output - the reoriented volume"
    inputBinding:
      position: 3
outputs:
  - id: output_volume
    type: File
    doc: "the reoriented volume"
    outputBinding:
      glob: $(inputs.volume_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
