cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmrep_vskel
label: meta-neuro_cmrep_vskel
doc: "Skeletonize a boundary mesh\n\nTool homepage: https://github.com/bagari/meta"
inputs:
  - id: boundary_mesh
    type: File
    doc: Boundary mesh to skeletonize
    inputBinding:
      position: 1
  - id: compute_geodesic
    type:
      - 'null'
      - boolean
    doc: Compute full geodesic information. This is only useful for debugging 
      the pruning code.
    inputBinding:
      position: 102
      prefix: -g
  - id: delaunay_tetrahedralization_mesh
    type:
      - 'null'
      - File
    doc: Generate a Delaunay tetrahedralization of the input point set, with the
      pruned parts of the skeleton excluded. Use with tetfill to generate a 
      thickness map in image space (different from -I output, this is distance 
      from the skeleton vertices to the boundary generator points
    inputBinding:
      position: 102
      prefix: -d
  - id: generate_thickness_map_boundary
    type:
      - 'null'
      - File
    doc: Generate thickness map on the boundary. The thickness is the distance 
      from each boundary point to the closest pruned skeleton point
    inputBinding:
      position: 102
      prefix: -T
  - id: input_image_for_thickness
    type:
      - 'null'
      - type: array
        items: File
    doc: Generate thickness map in an image. Input is a binary image. Output 1 
      is a thickness image; Output 2 is a depth map. Input image
    inputBinding:
      position: 102
      prefix: -I
  - id: load_skeleton
    type:
      - 'null'
      - File
    doc: Load a skeleton from mesh.vtk and compare to the output skeleton
    inputBinding:
      position: 102
      prefix: -s
  - id: max_connected_components
    type:
      - 'null'
      - int
    doc: Take at most N connected components of the skeleton
    inputBinding:
      position: 102
      prefix: -c
  - id: min_edges_separating_generators
    type:
      - 'null'
      - int
    doc: Minimal number of mesh edges separating two generator points of a VD 
      face for it to be considered (try 2, 3)
    inputBinding:
      position: 102
      prefix: -e
  - id: num_random_samples
    type:
      - 'null'
      - type: array
        items: int
    doc: Generate N random samples from the skeleton and save their coordiantes 
      to xyz.mat and geodesic distances to d.mat. N
    inputBinding:
      position: 102
      prefix: -R
  - id: pruning_factor
    type:
      - 'null'
      - float
    doc: Prune the mesh using factor X.XX (try 2.0). The pruning algorithm 
      deletes faces in the VD for which the ratio of the geodesic distance 
      between the generating points and the euclidean distance between these 
      points is less than X.XX
    inputBinding:
      position: 102
      prefix: -p
  - id: pruning_tolerance
    type:
      - 'null'
      - float
    doc: Tolerance for the inside/outside search algorithm (default 1e-6). Use 
      lower values if holes appear in the skeleton. Set to zero to disable 
      pruning of outside vertices
    inputBinding:
      position: 102
      prefix: -t
  - id: quadric_clustering_bins
    type:
      - 'null'
      - int
    doc: Postprocess skeleton with VTK's quadric clustering filter. The effect 
      is to reduce the number of vertices in the skeleton. Parameter n_bins is 
      the number of bins in each dimension. A good value for n_bins is 20-50
    inputBinding:
      position: 102
      prefix: -q
  - id: qvoronoi_path
    type:
      - 'null'
      - File
    doc: Path to the qvoronoi executable
    inputBinding:
      position: 102
      prefix: -Q
  - id: random_samples_coords_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Generate N random samples from the skeleton and save their coordiantes 
      to xyz.mat and geodesic distances to d.mat. xyz.mat
    inputBinding:
      position: 102
      prefix: -R
  - id: random_samples_distances_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Generate N random samples from the skeleton and save their coordiantes 
      to xyz.mat and geodesic distances to d.mat. d.mat
    inputBinding:
      position: 102
      prefix: -R
  - id: sample_array_name
    type:
      - 'null'
      - type: array
        items: string
    doc: Sample from image 'image' and store as array 'array'. mode is one of 
      'mean', 'max'. Must be used together with -T command. Array name
    inputBinding:
      position: 102
      prefix: -S
  - id: sample_image
    type:
      - 'null'
      - type: array
        items: File
    doc: Sample from image 'image' and store as array 'array'. mode is one of 
      'mean', 'max'. Must be used together with -T command. Image
    inputBinding:
      position: 102
      prefix: -S
  - id: sample_mode
    type:
      - 'null'
      - type: array
        items: string
    doc: Sample from image 'image' and store as array 'array'. mode is one of 
      'mean', 'max'. Must be used together with -T command. Mode
    inputBinding:
      position: 102
      prefix: -S
  - id: subdivide_level
    type:
      - 'null'
      - type: array
        items: int
    doc: Subdivide input mesh prior to skeletonization. Level
    inputBinding:
      position: 102
      prefix: -z
  - id: subdivide_mode
    type:
      - 'null'
      - type: array
        items: string
    doc: Subdivide input mesh prior to skeletonization. Mode is either 'loop' or
      'linear'
    inputBinding:
      position: 102
      prefix: -z
outputs:
  - id: output_skeleton
    type: File
    doc: Where to output the skeleton
    outputBinding:
      glob: '*.out'
  - id: output_thickness_image
    type:
      - 'null'
      - File
    doc: Generate thickness map in an image. Input is a binary image. Output 1 
      is a thickness image; Output 2 is a depth map. Output thickness image
    outputBinding:
      glob: $(inputs.output_thickness_image)
  - id: output_depth_map_image
    type:
      - 'null'
      - File
    doc: Generate thickness map in an image. Input is a binary image. Output 1 
      is a thickness image; Output 2 is a depth map. Output depth map
    outputBinding:
      glob: $(inputs.output_depth_map_image)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-neuro:2.0.1--py313h47f2c4e_0
