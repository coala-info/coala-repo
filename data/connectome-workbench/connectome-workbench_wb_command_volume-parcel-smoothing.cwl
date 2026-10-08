cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-parcel-smoothing
label: connectome-workbench_wb_command_volume-parcel-smoothing
doc: "The volume is smoothed within each label in the label volume using data only from within the label. Equivalent to running volume smoothing with ROIs matching each label separately, then adding the resulting volumes, but faster.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: data_volume
    type: File
    doc: "the volume to smooth"
    inputBinding:
      position: 1
  - id: label_volume
    type: File
    doc: "a label volume containing the parcels to smooth"
    inputBinding:
      position: 2
  - id: kernel
    type: float
    doc: "the gaussian smoothing kernel sigma, in mm"
    inputBinding:
      position: 3
  - id: volume_out
    type: string
    doc: "output - the output volume"
    inputBinding:
      position: 4
  - id: fix_zeros
    type:
      - 'null'
      - boolean
    doc: "treat zero values as not being data"
    inputBinding:
      position: 5
      prefix: -fix-zeros
  - id: subvolume
    type:
      - 'null'
      - string
    doc: "select a single subvolume to smooth: the subvolume number or name"
    inputBinding:
      position: 6
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
