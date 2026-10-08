cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-erode
label: connectome-workbench_wb_command_volume-erode
doc: "Around each voxel with a value of zero, set surrounding voxels to zero. The surrounding voxels are all face neighbors and all voxels within the specified distance (center to center).\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: volume
    type: File
    doc: "the volume to erode"
    inputBinding:
      position: 1
  - id: distance
    type: float
    doc: "distance in mm to erode"
    inputBinding:
      position: 2
  - id: volume_out
    type: string
    doc: "output - the output volume"
    inputBinding:
      position: 3
  - id: roi
    type:
      - 'null'
      - File
    doc: "assume voxels outside this roi are nonzero: volume file, positive values denote voxels that have data"
    inputBinding:
      position: 4
      prefix: -roi
  - id: subvolume
    type:
      - 'null'
      - string
    doc: "select a single subvolume to dilate: the subvolume number or name"
    inputBinding:
      position: 5
      prefix: -subvolume
outputs:
  - id: output_volume
    type: File
    doc: "the output volume"
    outputBinding:
      glob: $(inputs.volume_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
