cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-convert-matrix4-to-workbench-sparse'
label: connectome-workbench_wb_command_convert-matrix4-to-workbench-sparse
doc: "Convert a 3-file matrix4 (probtrackx matrix 4 output) to a workbench sparse file. Exactly one of -surface-seeds and -volume-seeds must be specified.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: matrix4_1
    type: File
    doc: the first matrix4 file
    inputBinding:
      position: 1
  - id: matrix4_2
    type: File
    doc: the second matrix4 file
    inputBinding:
      position: 2
  - id: matrix4_3
    type: File
    doc: the third matrix4 file
    inputBinding:
      position: 3
  - id: orientation_file
    type: File
    doc: the .fiberTEMP.nii file this trajectory file applies to
    inputBinding:
      position: 4
  - id: voxel_list
    type: File
    doc: list of white matter voxel index triplets as used in the trajectory matrix
    inputBinding:
      position: 5
  - id: wb_sparse_out
    type: string
    doc: output - the output workbench sparse file
    inputBinding:
      position: 6
  - id: surface_seeds
    type:
      - 'null'
      - File
    doc: 'specify the surface seed space: metric roi file of all vertices used in the seed space'
    inputBinding:
      position: 7
      prefix: '-surface-seeds'
  - id: volume_seeds_template
    type:
      - 'null'
      - File
    doc: 'specify the volume seed space: cifti file to use the volume mappings from'
    inputBinding:
      position: 8
      prefix: '-volume-seeds'
  - id: volume_seeds_direction
    type:
      - 'null'
      - string
    doc: 'with volume_seeds_template: dimension along the cifti file to take the mapping from, ROW or COLUMN'
    inputBinding:
      position: 9
outputs:
  - id: wb_sparse
    type: File
    doc: the output workbench sparse file
    outputBinding:
      glob: $(inputs.wb_sparse_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
