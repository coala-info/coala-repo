cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-cifti-restrict-dense-map'
label: connectome-workbench_wb_command_cifti-restrict-dense-map
doc: "Exclude brainordinates from a cifti file. Writes a modified version of <cifti-in>, where all brainordinates outside the specified roi(s) are removed from the file. If -cifti-roi is specified, no other -*-roi option may be specified. If not using -cifti-roi, any -*-roi options not present will discard the relevant structure, if present in the input file.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: cifti_in
    type: File
    doc: the input cifti
    inputBinding:
      position: 1
  - id: direction
    type: string
    doc: "which dimension to change the mapping on (integer, 'ROW', or 'COLUMN')"
    inputBinding:
      position: 2
  - id: cifti_out
    type: string
    doc: output - the output cifti
    inputBinding:
      position: 3
  - id: cifti_roi
    type:
      - 'null'
      - File
    doc: cifti file containing combined rois
    inputBinding:
      position: 10
      prefix: '-cifti-roi'
  - id: left_roi
    type:
      - 'null'
      - File
    doc: vertices to use from left hemisphere, as a metric file
    inputBinding:
      position: 11
      prefix: '-left-roi'
  - id: right_roi
    type:
      - 'null'
      - File
    doc: vertices to use from right hemisphere, as a metric file
    inputBinding:
      position: 12
      prefix: '-right-roi'
  - id: cerebellum_roi
    type:
      - 'null'
      - File
    doc: vertices to use from cerebellum, as a metric file
    inputBinding:
      position: 13
      prefix: '-cerebellum-roi'
  - id: vol_roi
    type:
      - 'null'
      - File
    doc: voxels to use, as a volume file
    inputBinding:
      position: 14
      prefix: '-vol-roi'
outputs:
  - id: restricted_cifti
    type: File
    doc: the output cifti
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
