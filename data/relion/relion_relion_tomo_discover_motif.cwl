cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_tomo_discover_motif
label: relion_relion_tomo_discover_motif
doc: "Discover repeating lattice motifs in a point cloud (CSV of 3D points).\n\nTool homepage: https://github.com/3dem/relion"
inputs:
  - id: point_cloud
    type: File
    doc: Point cloud (.csv)
    inputBinding:
      position: 101
      prefix: --p
  - id: output
    type: string
    doc: Output filename
    inputBinding:
      position: 101
      prefix: --o
  - id: min_spacing
    type:
      - 'null'
      - float
    doc: 'Min. lattice spacing (RELION default: 6.5)'
    inputBinding:
      position: 101
      prefix: --d0
  - id: max_spacing
    type:
      - 'null'
      - float
    doc: 'Max. lattice spacing (RELION default: 8.5)'
    inputBinding:
      position: 101
      prefix: --d1
  - id: neighbors
    type:
      - 'null'
      - int
    doc: 'Number of neighbors (RELION default: 6)'
    inputBinding:
      position: 101
      prefix: --n
  - id: motifs
    type:
      - 'null'
      - int
    doc: 'Number of motifs to return (RELION default: 5)'
    inputBinding:
      position: 101
      prefix: --m
  - id: bin
    type:
      - 'null'
      - float
    doc: 'Binning of the point cloud (RELION default: 8.0)'
    inputBinding:
      position: 101
      prefix: --bin
  - id: min_score
    type:
      - 'null'
      - int
    doc: 'Minimal score for a point to be used in motif refinement (RELION default: 3)'
    inputBinding:
      position: 101
      prefix: --min_score
  - id: tolerance
    type:
      - 'null'
      - float
    doc: 'Tolerance [Px] (RELION default: 0.25)'
    inputBinding:
      position: 101
      prefix: --tol
  - id: regulariser
    type:
      - 'null'
      - float
    doc: 'Regularizer constant: inhibits movement of motif points during refinement (RELION default: 0.1)'
    inputBinding:
      position: 101
      prefix: --reg
  - id: motifs_to_test
    type:
      - 'null'
      - int
    doc: 'Number of motifs to test (RELION default: 1000)'
    inputBinding:
      position: 101
      prefix: --nm
  - id: points_to_test
    type:
      - 'null'
      - int
    doc: 'Number of points to test against (RELION default: 10000)'
    inputBinding:
      position: 101
      prefix: --ne
  - id: ref_disc
    type:
      - 'null'
      - boolean
    doc: Refine motif locally during discovery
    inputBinding:
      position: 101
      prefix: --ref-disc
  - id: no_ref_det
    type:
      - 'null'
      - boolean
    doc: Skip local refinement for motif detection
    inputBinding:
      position: 101
      prefix: --no_ref-det
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --j
  - id: distance_histogram
    type:
      - 'null'
      - boolean
    doc: Compute the distance density, then quit
    inputBinding:
      position: 101
      prefix: --dh
  - id: distance_histogram_max
    type:
      - 'null'
      - float
    doc: 'Max. distance (RELION default: 50)'
    inputBinding:
      position: 101
      prefix: --dhmax
  - id: distance_histogram_bins
    type:
      - 'null'
      - int
    doc: 'Number of bins (RELION default: 256)'
    inputBinding:
      position: 101
      prefix: --dhb
  - id: neighbor_count_histogram
    type:
      - 'null'
      - boolean
    doc: Compute neighbor-count histogram, then quit
    inputBinding:
      position: 101
      prefix: --nch
  - id: neighbor_count_histogram_max
    type:
      - 'null'
      - int
    doc: 'Max. neighbor count (RELION default: 20)'
    inputBinding:
      position: 101
      prefix: --nchmax
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Motifs, detections, distance and neighbour-count histograms
    outputBinding:
      glob: $(inputs.output)*
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_tomo_discover_motif.out
