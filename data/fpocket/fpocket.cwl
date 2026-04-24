cwlVersion: v1.2
class: CommandLineTool
baseCommand: fpocket
label: fpocket
doc: "fpocket is a very fast open source protein pocket detection algorithm based
  on Voronoi tessellation.\n\nTool homepage: https://github.com/Discngine/fpocket"
inputs:
  - id: clustering_distance
    type:
      - 'null'
      - float
    doc: The distance threshold for clustering alpha spheres
    inputBinding:
      position: 101
      prefix: -D
  - id: clustering_method
    type:
      - 'null'
      - string
    doc: The clustering method to use (single, complete, average, centroid, 
      ward)
    inputBinding:
      position: 101
      prefix: -r
  - id: extract_pockets
    type:
      - 'null'
      - boolean
    doc: Extract pockets as separate PDB files
    inputBinding:
      position: 101
      prefix: -e
  - id: input_pdb
    type: File
    doc: Input PDB file
    inputBinding:
      position: 101
      prefix: -f
  - id: max_sphere_radius
    type:
      - 'null'
      - float
    doc: The maximum radius of an alpha sphere
    inputBinding:
      position: 101
      prefix: -M
  - id: min_alpha_spheres
    type:
      - 'null'
      - int
    doc: The minimum number of alpha spheres per pocket
    inputBinding:
      position: 101
      prefix: -i
  - id: min_sphere_radius
    type:
      - 'null'
      - float
    doc: The minimum radius of an alpha sphere
    inputBinding:
      position: 101
      prefix: -m
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fpocket:4.0.0
stdout: fpocket.out
