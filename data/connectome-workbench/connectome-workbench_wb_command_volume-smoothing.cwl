cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-smoothing
label: connectome-workbench_wb_command_volume-smoothing
doc: "Gaussian smoothing for volumes. By default, smooths all subvolumes with no
  ROI, if ROI is given, only positive voxels in the ROI volume have their values
  used, and all other voxels are set to zero. The -fix-zeros option causes the
  smoothing to not use an input value if it is zero, but still write a smoothed
  value to the voxel.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: volume_in
    type: File
    doc: the volume to smooth
    inputBinding:
      position: 1
  - id: kernel
    type: float
    doc: the gaussian smoothing kernel sigma, in mm
    inputBinding:
      position: 2
  - id: volume_out
    type: string
    doc: output - the output volume
    inputBinding:
      position: 3
  - id: roi
    type:
      - 'null'
      - File
    doc: smooth only from data within an ROI, given as a volume
    inputBinding:
      position: 4
      prefix: -roi
  - id: fix_zeros
    type:
      - 'null'
      - boolean
    doc: treat zero values as not being data
    inputBinding:
      position: 4
      prefix: -fix-zeros
  - id: subvolume
    type:
      - 'null'
      - string
    doc: select a single subvolume to smooth (number or name)
    inputBinding:
      position: 4
      prefix: -subvolume
outputs:
  - id: smoothed_volume
    type: File
    doc: the output volume
    outputBinding:
      glob: $(inputs.volume_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
