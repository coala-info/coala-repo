cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -probtrackx-dot-convert
label: connectome-workbench_wb_command_probtrackx-dot-convert
doc: 'NOTE: exactly one -row option and one -col option must be used.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
requirements:
  - class: SchemaDefRequirement
    types:
      - name: row_voxels_rec
        type: record
        fields:
          - name: voxel_list_file
            type: File
            doc: a text file containing IJK indices for the voxels used
            inputBinding:
              position: 1
          - name: label_vol
            type: File
            doc: a label volume with the dimensions and sform used, with structure
              labels
            inputBinding:
              position: 2
      - name: row_cifti_rec
        type: record
        fields:
          - name: cifti
            type: File
            doc: the cifti file to take the mapping from
            inputBinding:
              position: 1
          - name: direction
            type: string
            doc: which dimension to take the mapping along, ROW or COLUMN
            inputBinding:
              position: 2
      - name: col_voxels_rec
        type: record
        fields:
          - name: voxel_list_file
            type: File
            doc: a text file containing IJK indices for the voxels used
            inputBinding:
              position: 1
          - name: label_vol
            type: File
            doc: a label volume with the dimensions and sform used, with structure
              labels
            inputBinding:
              position: 2
      - name: col_cifti_rec
        type: record
        fields:
          - name: cifti
            type: File
            doc: the cifti file to take the mapping from
            inputBinding:
              position: 1
          - name: direction
            type: string
            doc: which dimension to take the mapping along, ROW or COLUMN
            inputBinding:
              position: 2
inputs:
  - id: dot_file
    type: File
    doc: input .dot file
    inputBinding:
      position: 1
  - id: cifti_out
    type: string
    doc: output - output cifti file
    inputBinding:
      position: 2
  - id: row_voxels
    type:
      - 'null'
      - row_voxels_rec
    doc: the output mapping along a row will be voxels
    inputBinding:
      position: 3
      prefix: -row-voxels
  - id: row_surface
    type:
      - 'null'
      - File
    doc: the output mapping along a row will be surface vertices
    inputBinding:
      position: 3
      prefix: -row-surface
  - id: row_cifti
    type:
      - 'null'
      - row_cifti_rec
    doc: take the mapping along a row from a cifti file
    inputBinding:
      position: 3
      prefix: -row-cifti
  - id: col_voxels
    type:
      - 'null'
      - col_voxels_rec
    doc: the output mapping along a column will be voxels
    inputBinding:
      position: 3
      prefix: -col-voxels
  - id: col_surface
    type:
      - 'null'
      - File
    doc: the output mapping along a column will be surface vertices
    inputBinding:
      position: 3
      prefix: -col-surface
  - id: col_cifti
    type:
      - 'null'
      - col_cifti_rec
    doc: take the mapping along a column from a cifti file
    inputBinding:
      position: 3
      prefix: -col-cifti
  - id: transpose
    type:
      - 'null'
      - boolean
    doc: transpose the input matrix
    inputBinding:
      position: 3
      prefix: -transpose
  - id: make_symmetric
    type:
      - 'null'
      - boolean
    doc: transform half-square input into full matrix output
    inputBinding:
      position: 3
      prefix: -make-symmetric
outputs:
  - id: cifti_out_file
    type: File
    doc: output cifti file
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
