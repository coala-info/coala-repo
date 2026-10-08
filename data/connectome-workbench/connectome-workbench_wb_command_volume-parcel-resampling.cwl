cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-parcel-resampling
label: connectome-workbench_wb_command_volume-parcel-resampling
doc: "Smooths and resamples the region inside each label in cur-parcels to the region of the same label name in new-parcels. Any voxels in the output label region but outside the input label region will be extrapolated from nearby data. The -fix-zeros option causes the smoothing to not use an input value if it is zero, but still write a smoothed value to the voxel, and after smoothing is complete, it will check for any remaining values of zero, and fill them in with extrapolated values.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: volume_in
    type: File
    doc: "the input data volume"
    inputBinding:
      position: 1
  - id: cur_parcels
    type: File
    doc: "label volume of where the parcels currently are"
    inputBinding:
      position: 2
  - id: new_parcels
    type: File
    doc: "label volume of where the parcels should be"
    inputBinding:
      position: 3
  - id: kernel
    type: float
    doc: "gaussian kernel sigma to smooth by during resampling"
    inputBinding:
      position: 4
  - id: volume_out
    type: string
    doc: "output - output volume"
    inputBinding:
      position: 5
  - id: fix_zeros
    type:
      - 'null'
      - boolean
    doc: "treat zero values as not being data"
    inputBinding:
      position: 6
      prefix: -fix-zeros
  - id: subvolume
    type:
      - 'null'
      - string
    doc: "select a single subvolume as input: the subvolume number or name"
    inputBinding:
      position: 7
      prefix: -subvolume
outputs:
  - id: output_volume
    type: File
    doc: "output volume"
    outputBinding:
      glob: $(inputs.volume_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
