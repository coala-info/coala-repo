cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-set-space
label: connectome-workbench_wb_command_volume-set-space
doc: "Writes a copy of the volume file, with the spacing information changed as specified. No reordering of the voxel data occurs, see -volume-reorient to change the volume indexing order and reorder the voxels to match. Exactly one of -plumb, -sform, or -file must be specified.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: volume_in
    type: File
    doc: "the input volume"
    inputBinding:
      position: 1
  - id: volume_out
    type: string
    doc: "output - the output volume"
    inputBinding:
      position: 2
  - id: plumb_axis_order
    type:
      - 'null'
      - string
    doc: "a string like 'XYZ' that specifies which index is along which spatial dimension (-plumb argument 1 of 7)"
    inputBinding:
      position: 3
      prefix: -plumb
  - id: plumb_x_spacing
    type:
      - 'null'
      - float
    doc: "change in x-coordinate from incrementing the relevant index (-plumb argument 2 of 7)"
    inputBinding:
      position: 4
  - id: plumb_y_spacing
    type:
      - 'null'
      - float
    doc: "change in y-coordinate from incrementing the relevant index (-plumb argument 3 of 7)"
    inputBinding:
      position: 5
  - id: plumb_z_spacing
    type:
      - 'null'
      - float
    doc: "change in z-coordinate from incrementing the relevant index (-plumb argument 4 of 7)"
    inputBinding:
      position: 6
  - id: plumb_x_offset
    type:
      - 'null'
      - float
    doc: "the x-coordinate of the first voxel (-plumb argument 5 of 7)"
    inputBinding:
      position: 7
  - id: plumb_y_offset
    type:
      - 'null'
      - float
    doc: "the y-coordinate of the first voxel (-plumb argument 6 of 7)"
    inputBinding:
      position: 8
  - id: plumb_z_offset
    type:
      - 'null'
      - float
    doc: "the z-coordinate of the first voxel (-plumb argument 7 of 7)"
    inputBinding:
      position: 9
  - id: sform_xi_spacing
    type:
      - 'null'
      - float
    doc: "increase in x coordinate from incrementing the i index (-sform argument 1 of 12)"
    inputBinding:
      position: 10
      prefix: -sform
  - id: sform_xj_spacing
    type:
      - 'null'
      - float
    doc: "increase in x coordinate from incrementing the j index (-sform argument 2 of 12)"
    inputBinding:
      position: 11
  - id: sform_xk_spacing
    type:
      - 'null'
      - float
    doc: "increase in x coordinate from incrementing the k index (-sform argument 3 of 12)"
    inputBinding:
      position: 12
  - id: sform_x_offset
    type:
      - 'null'
      - float
    doc: "x coordinate of first voxel (-sform argument 4 of 12)"
    inputBinding:
      position: 13
  - id: sform_yi_spacing
    type:
      - 'null'
      - float
    doc: "increase in y coordinate from incrementing the i index (-sform argument 5 of 12)"
    inputBinding:
      position: 14
  - id: sform_yj_spacing
    type:
      - 'null'
      - float
    doc: "increase in y coordinate from incrementing the j index (-sform argument 6 of 12)"
    inputBinding:
      position: 15
  - id: sform_yk_spacing
    type:
      - 'null'
      - float
    doc: "increase in y coordinate from incrementing the k index (-sform argument 7 of 12)"
    inputBinding:
      position: 16
  - id: sform_y_offset
    type:
      - 'null'
      - float
    doc: "y coordinate of first voxel (-sform argument 8 of 12)"
    inputBinding:
      position: 17
  - id: sform_zi_spacing
    type:
      - 'null'
      - float
    doc: "increase in z coordinate from incrementing the i index (-sform argument 9 of 12)"
    inputBinding:
      position: 18
  - id: sform_zj_spacing
    type:
      - 'null'
      - float
    doc: "increase in z coordinate from incrementing the j index (-sform argument 10 of 12)"
    inputBinding:
      position: 19
  - id: sform_zk_spacing
    type:
      - 'null'
      - float
    doc: "increase in z coordinate from incrementing the k index (-sform argument 11 of 12)"
    inputBinding:
      position: 20
  - id: sform_z_offset
    type:
      - 'null'
      - float
    doc: "z coordinate of first voxel (-sform argument 12 of 12)"
    inputBinding:
      position: 21
  - id: volume_ref
    type:
      - 'null'
      - File
    doc: "copy spacing info from volume file with matching dimensions: volume file to use for reference space"
    inputBinding:
      position: 22
      prefix: -file
  - id: ignore_dims
    type:
      - 'null'
      - boolean
    doc: "copy the spacing info even if the dimensions don't match (sub-option of -file)"
    inputBinding:
      position: 23
      prefix: -ignore-dims
outputs:
  - id: output_volume
    type: File
    doc: "the output volume"
    outputBinding:
      glob: $(inputs.volume_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
