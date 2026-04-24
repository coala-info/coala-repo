cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hotspot3d
  - main
label: hotspot3d_main
doc: "Hotspot3D main pipeline for proximity search, clustering, and analysis of mutations.\n\
  \nTool homepage: https://github.com/ding-lab/hotspot3d"
inputs:
  - id: amino_acid_header
    type:
      - 'null'
      - string
    doc: .maf file column header for amino acid changes
    inputBinding:
      position: 101
      prefix: --amino-acid-header
  - id: clustering
    type:
      - 'null'
      - string
    doc: Cluster using network or density-based methods (network or density)
    inputBinding:
      position: 101
      prefix: --clustering
  - id: distance_measure
    type:
      - 'null'
      - string
    doc: Pair distance to use (shortest or average)
    inputBinding:
      position: 101
      prefix: --distance-measure
  - id: drugport_file
    type:
      - 'null'
      - File
    doc: DrugPort database parsing results file
    inputBinding:
      position: 101
      prefix: --drugport-file
  - id: linear_cutoff
    type:
      - 'null'
      - int
    doc: Linear distance cutoff (> peptides)
    inputBinding:
      position: 101
      prefix: --linear-cutoff
  - id: maf_file
    type: File
    doc: .maf file used in proximity search step (used if vertex-type = 
      recurrence)
    inputBinding:
      position: 101
      prefix: --maf-file
  - id: max_radius
    type:
      - 'null'
      - float
    doc: Maximum cluster radius (max network geodesic from centroid, <= 
      Angstroms)
    inputBinding:
      position: 101
      prefix: --max-radius
  - id: missense_only
    type:
      - 'null'
      - string
    doc: missense mutation only
    inputBinding:
      position: 101
      prefix: --missense-only
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix of output files
    inputBinding:
      position: 101
      prefix: --output-prefix
  - id: p_value_cutoff
    type:
      - 'null'
      - float
    doc: P_value cutoff (<) (if 3d-distance-cutoff also not set)
    inputBinding:
      position: 101
      prefix: --p-value-cutoff
  - id: simulations
    type:
      - 'null'
      - int
    doc: Number of simulations
    inputBinding:
      position: 101
      prefix: --simulations
  - id: skip_silent
    type:
      - 'null'
      - string
    doc: skip silent mutations
    inputBinding:
      position: 101
      prefix: --skip-silent
  - id: start
    type:
      - 'null'
      - string
    doc: Step to start on (search, post, cluster, sigclus, summary, visual)
    inputBinding:
      position: 101
      prefix: --start
  - id: three_d_distance_cutoff
    type:
      - 'null'
      - float
    doc: 3D distance cutoff (<) (if p-value-cutoff also not set)
    inputBinding:
      position: 101
      prefix: --3d-distance-cutoff
  - id: transcript_id_header
    type:
      - 'null'
      - string
    doc: .maf file column header for transcript id's
    inputBinding:
      position: 101
      prefix: --transcript-id-header
  - id: vertex_type
    type:
      - 'null'
      - string
    doc: Graph vertex type for network-based clustering (recurrence, unique, or 
      weight)
    inputBinding:
      position: 101
      prefix: --vertex-type
  - id: weight_header
    type:
      - 'null'
      - string
    doc: .maf file column header for mutation weight (used if vertex-type = 
      weight)
    inputBinding:
      position: 101
      prefix: --weight-header
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory of proximity files
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
