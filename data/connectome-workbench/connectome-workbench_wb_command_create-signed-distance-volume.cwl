cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-create-signed-distance-volume'
label: connectome-workbench_wb_command_create-signed-distance-volume
doc: "Create a signed distance volume from a surface. Exact distance is calculated by finding the closest point on any surface triangle to the center of the voxel. Approximate distance is calculated starting with these distances, using dijkstra's method with a neighborhood of voxels. Winding methods: EVEN_ODD (default), NEGATIVE, NONZERO, NORMALS.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: surface
    type: File
    doc: the input surface
    inputBinding:
      position: 1
  - id: refspace
    type: File
    doc: a volume in the desired output space (dims, spacing, origin)
    inputBinding:
      position: 2
  - id: outvol
    type: string
    doc: output - the output volume
    inputBinding:
      position: 3
  - id: roi_out
    type:
      - 'null'
      - string
    doc: output - output an roi volume of where the output has a computed value
    inputBinding:
      position: 4
      prefix: '-roi-out'
  - id: fill_value
    type:
      - 'null'
      - float
    doc: "value to put in all voxels that don't get assigned a distance (default 0)"
    inputBinding:
      position: 4
      prefix: '-fill-value'
  - id: exact_limit
    type:
      - 'null'
      - float
    doc: distance in mm for exact output (default 5)
    inputBinding:
      position: 4
      prefix: '-exact-limit'
  - id: approx_limit
    type:
      - 'null'
      - float
    doc: distance in mm for approximate output (default 20)
    inputBinding:
      position: 4
      prefix: '-approx-limit'
  - id: approx_neighborhood
    type:
      - 'null'
      - int
    doc: voxel neighborhood for approximate calculation, size of cube from center to face in voxels (default 2 = 5x5x5)
    inputBinding:
      position: 4
      prefix: '-approx-neighborhood'
  - id: winding
    type:
      - 'null'
      - string
    doc: 'winding method for point inside surface test: EVEN_ODD (default), NEGATIVE, NONZERO or NORMALS'
    inputBinding:
      position: 4
      prefix: '-winding'
outputs:
  - id: distance_volume
    type: File
    doc: the output signed distance volume
    outputBinding:
      glob: $(inputs.outvol)
  - id: roi_volume
    type:
      - 'null'
      - File
    doc: the output roi volume
    outputBinding:
      glob: $(inputs.roi_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
