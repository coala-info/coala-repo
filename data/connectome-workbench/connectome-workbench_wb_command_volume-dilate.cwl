cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-dilate
label: connectome-workbench_wb_command_volume-dilate
doc: "For all voxels that are designated as bad, if they neighbor a non-bad voxel with data or are within the specified distance of such a voxel, replace the value in the bad voxel with a value calculated from nearby non-bad voxels that have data, otherwise set the value to zero. No matter how small <distance> is, dilation will always use at least the face neighbor voxels.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: volume
    type: File
    doc: "the volume to dilate"
    inputBinding:
      position: 1
  - id: distance
    type: float
    doc: "distance in mm to dilate"
    inputBinding:
      position: 2
  - id: method
    type: string
    doc: "dilation method to use: NEAREST or WEIGHTED"
    inputBinding:
      position: 3
  - id: volume_out
    type: string
    doc: "output - the output volume"
    inputBinding:
      position: 4
  - id: exponent
    type:
      - 'null'
      - float
    doc: "use a different exponent in the weighting function: exponent 'n' to use in (1 / (distance ^ n)) as the weighting function (default 2)"
    inputBinding:
      position: 5
      prefix: -exponent
  - id: bad_voxel_roi
    type:
      - 'null'
      - File
    doc: "specify an roi of voxels to overwrite, rather than voxels with value zero: volume file, positive values denote voxels to have their values replaced"
    inputBinding:
      position: 6
      prefix: -bad-voxel-roi
  - id: data_roi
    type:
      - 'null'
      - File
    doc: "specify an roi of where there is data: volume file, positive values denote voxels that have data"
    inputBinding:
      position: 7
      prefix: -data-roi
  - id: subvolume
    type:
      - 'null'
      - string
    doc: "select a single subvolume to dilate: the subvolume number or name"
    inputBinding:
      position: 8
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
