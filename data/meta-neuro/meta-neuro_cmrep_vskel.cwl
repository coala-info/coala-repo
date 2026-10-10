cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmrep_vskel
label: meta-neuro_cmrep_vskel
doc: "Computes the Voronoi skeleton (medial surface) of a boundary mesh with pruning
  options.\n\nTool homepage: https://github.com/bagari/meta"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: boundary
    type: File
    doc: Boundary mesh to skeletonize (boundary.vtk)
    inputBinding:
      position: 100
  - id: output_skeleton
    type: string
    doc: Where to output the skeleton (output_skeleton.vtk)
    inputBinding:
      position: 101
  - id: qvoronoi_path
    type:
      - 'null'
      - string
    doc: Path to the qvoronoi executable
    inputBinding:
      position: 3
      prefix: -Q
  - id: subdivide_level
    type:
      - 'null'
      - int
    doc: Subdivide input mesh prior to skeletonization, <level> (use together with subdivide_mode)
    inputBinding:
      position: 4
      prefix: -z
  - id: subdivide_mode
    type:
      - 'null'
      - string
    doc: Subdivision mode, either 'loop' or 'linear' (use together with subdivide_level)
    inputBinding:
      position: 5
  - id: min_edges
    type:
      - 'null'
      - int
    doc: Minimal number of mesh edges separating two generator points of a VD face
      for it to be considered (try 2, 3)
    inputBinding:
      position: 6
      prefix: -e
  - id: prune_factor
    type:
      - 'null'
      - float
    doc: Prune the mesh using factor X.XX (try 2.0); deletes faces in the VD for
      which the ratio of the geodesic distance between the generating points and the
      euclidean distance between these points is less than X.XX
    inputBinding:
      position: 7
      prefix: -p
  - id: max_components
    type:
      - 'null'
      - int
    doc: Take at most N connected components of the skeleton
    inputBinding:
      position: 8
      prefix: -c
  - id: full_geodesic
    type:
      - 'null'
      - boolean
    doc: Compute full geodesic information (only useful for debugging the pruning code)
    inputBinding:
      position: 9
      prefix: -g
  - id: tolerance
    type:
      - 'null'
      - float
    doc: Tolerance for the inside/outside search algorithm (default 1e-6); use lower
      values if holes appear in the skeleton, zero disables pruning of outside vertices
    inputBinding:
      position: 10
      prefix: -t
  - id: compare_skeleton
    type:
      - 'null'
      - File
    doc: Load a skeleton from mesh.vtk and compare to the output skeleton
    inputBinding:
      position: 11
      prefix: -s
  - id: random_samples
    type:
      - 'null'
      - int
    doc: Generate N random samples from the skeleton (use together with random_samples_xyz and random_samples_dist)
    inputBinding:
      position: 12
      prefix: -R
  - id: random_samples_xyz
    type:
      - 'null'
      - string
    doc: Output file for the coordinates of the random samples (xyz.mat)
    inputBinding:
      position: 13
  - id: random_samples_dist
    type:
      - 'null'
      - string
    doc: Output file for the geodesic distances of the random samples (d.mat)
    inputBinding:
      position: 14
  - id: thickness_map_vtk
    type:
      - 'null'
      - string
    doc: Generate thickness map on the boundary (name.vtk); the thickness is the
      distance from each boundary point to the closest pruned skeleton point
    inputBinding:
      position: 15
      prefix: -T
  - id: binary_image
    type:
      - 'null'
      - File
    doc: Generate thickness map in an image, input binary image (in.nii); use together
      with thickness_image and depth_image
    inputBinding:
      position: 16
      prefix: -I
  - id: thickness_image
    type:
      - 'null'
      - string
    doc: Output thickness image (thickness.nii)
    inputBinding:
      position: 17
  - id: depth_image
    type:
      - 'null'
      - string
    doc: Output depth map image (depth.nii)
    inputBinding:
      position: 18
  - id: quadric_bins
    type:
      - 'null'
      - int
    doc: Postprocess skeleton with VTK's quadric clustering filter; number of bins
      in each dimension (a good value is 20-50)
    inputBinding:
      position: 19
      prefix: -q
  - id: delaunay_mesh
    type:
      - 'null'
      - string
    doc: Generate a Delaunay tetrahedralization of the input point set, with the
      pruned parts of the skeleton excluded (mesh.vtk)
    inputBinding:
      position: 20
      prefix: -d
  - id: sample_image
    type:
      - 'null'
      - File
    doc: Sample from this image and store as an array (use with thickness_map_vtk,
      sample_array and sample_mode)
    inputBinding:
      position: 21
      prefix: -S
  - id: sample_array
    type:
      - 'null'
      - string
    doc: Name of the array that stores the sampled image values
    inputBinding:
      position: 22
  - id: sample_mode
    type:
      - 'null'
      - string
    doc: Sampling mode, one of 'mean' or 'max'
    inputBinding:
      position: 23
outputs:
  - id: skeleton
    type: File
    doc: Output skeleton
    outputBinding:
      glob: $(inputs.output_skeleton)
  - id: thickness_map
    type:
      - 'null'
      - File
    doc: Thickness map on the boundary
    outputBinding:
      glob: $(inputs.thickness_map_vtk)
  - id: random_sample_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Random sample coordinates and geodesic distances
    outputBinding:
      glob: |
        ${ return [inputs.random_samples_xyz, inputs.random_samples_dist].filter(function (x) { return x; }); }
  - id: image_outputs
    type:
      - 'null'
      - type: array
        items: File
    doc: Thickness and depth images
    outputBinding:
      glob: |
        ${ return [inputs.thickness_image, inputs.depth_image].filter(function (x) { return x; }); }
  - id: delaunay_output
    type:
      - 'null'
      - File
    doc: Delaunay tetrahedralization
    outputBinding:
      glob: $(inputs.delaunay_mesh)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-neuro:2.0.1--py313h47f2c4e_0
