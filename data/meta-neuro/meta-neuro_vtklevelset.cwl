cwlVersion: v1.2
class: CommandLineTool
baseCommand: vtklevelset
label: meta-neuro_vtklevelset
doc: "Generates a VTK mesh from a level set implicit surface defined by an input image.\n\
  \nTool homepage: https://github.com/bagari/meta"
inputs:
  - id: input_img
    type: File
    doc: Input image file defining the level set.
    inputBinding:
      position: 1
  - id: threshold
    type: float
    doc: The threshold value to define the level set surface.
    inputBinding:
      position: 2
  - id: apply_clean_filter
    type:
      - 'null'
      - boolean
    doc: Apply clean filter to the mesh.
    inputBinding:
      position: 103
      prefix: -k
  - id: clip_image
    type:
      - 'null'
      - File
    doc: Clip output (keep part where clipimage > 0).
    inputBinding:
      position: 103
      prefix: -c
  - id: delaunay_edge_flipping
    type:
      - 'null'
      - boolean
    doc: Perform Delaunay edge flipping.
    inputBinding:
      position: 103
      prefix: -d
  - id: ensure_outward_normals
    type:
      - 'null'
      - boolean
    doc: Make sure that normal vectors are facing outward.
    inputBinding:
      position: 103
      prefix: -f
  - id: export_voxel_coords
    type:
      - 'null'
      - boolean
    doc: Export mesh in voxel coordinates (not physical).
    inputBinding:
      position: 103
      prefix: -v
  - id: preserve_labels
    type:
      - 'null'
      - boolean
    doc: Preserve labels.
    inputBinding:
      position: 103
      prefix: -pl
  - id: reduce_mesh_size
    type:
      - 'null'
      - string
    doc: Reduce the size of the final mesh via quadric edge collapse algorithm 
      from MeshLab by a factor (e.g., 0.1) or to given number of vertices.
    inputBinding:
      position: 103
      prefix: -r
  - id: use_2d_algorithm
    type:
      - 'null'
      - boolean
    doc: Use 2D algorithm.
    inputBinding:
      position: 103
      prefix: '-2'
outputs:
  - id: output_vtk
    type: File
    doc: Output VTK file for the generated mesh.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-neuro:2.0.1--py313h47f2c4e_0
