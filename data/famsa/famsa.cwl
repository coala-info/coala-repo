cwlVersion: v1.2
class: CommandLineTool
baseCommand: famsa
label: famsa
doc: "FAMSA (Fast and Accurate Multiple Sequence Alignment) is a tool for multiple
  sequence alignment or profile-profile alignment.\n\nTool homepage: https://github.com/refresh-bio/FAMSA"
inputs:
  - id: input_file
    type: File
    doc: Input file in FASTA format. Can be replaced with STDIN.
    inputBinding:
      position: 1
  - id: input_file_2
    type:
      - 'null'
      - File
    doc: Second input file for profile-profile alignment.
    inputBinding:
      position: 2
  - id: disable_gap_optimization
    type:
      - 'null'
      - boolean
    doc: Disable gap optimization
    inputBinding:
      position: 103
      prefix: -dgo
  - id: disable_gap_rescaling
    type:
      - 'null'
      - boolean
    doc: Disable gap cost rescaling
    inputBinding:
      position: 103
      prefix: -dgr
  - id: disable_sum_of_pairs
    type:
      - 'null'
      - boolean
    doc: Disable sum of pairs optimization during refinement
    inputBinding:
      position: 103
      prefix: -dsp
  - id: dist_export
    type:
      - 'null'
      - boolean
    doc: Export a distance matrix to output file in CSV format
    inputBinding:
      position: 103
      prefix: -dist_export
  - id: distance_measure
    type:
      - 'null'
      - string
    doc: Pairwise distance measure (indel_div_lcs | indel075_div_lcs)
    inputBinding:
      position: 103
      prefix: -dist
  - id: gap_cost_scaler_div
    type:
      - 'null'
      - int
    doc: Gap cost scaler div-term
    inputBinding:
      position: 103
      prefix: -gsd
  - id: gap_cost_scaler_log
    type:
      - 'null'
      - int
    doc: Gap cost scaler log-term
    inputBinding:
      position: 103
      prefix: -gsl
  - id: gap_extension
    type:
      - 'null'
      - int
    doc: Gap extension cost
    inputBinding:
      position: 103
      prefix: -ge
  - id: gap_open
    type:
      - 'null'
      - int
    doc: Gap open cost
    inputBinding:
      position: 103
      prefix: -go
  - id: gt_export
    type:
      - 'null'
      - boolean
    doc: Export a guide tree to output file in Newick format
    inputBinding:
      position: 103
      prefix: -gt_export
  - id: guide_tree_method
    type:
      - 'null'
      - string
    doc: 'Guide tree method: sl (single linkage), upgma, nj, or import <file>'
    inputBinding:
      position: 103
      prefix: -gt
  - id: gz
    type:
      - 'null'
      - boolean
    doc: Enable gzipped output
    inputBinding:
      position: 103
      prefix: -gz
  - id: gz_lev
    type:
      - 'null'
      - int
    doc: Gzip compression level [0-9]
    inputBinding:
      position: 103
      prefix: -gz-lev
  - id: keep_duplicates
    type:
      - 'null'
      - boolean
    doc: Keep duplicated sequences during alignment
    inputBinding:
      position: 103
      prefix: -keep-duplicates
  - id: medoid_threshold
    type:
      - 'null'
      - int
    doc: If specified, medoid trees are used only for sets with <n_seqs> or more
    inputBinding:
      position: 103
      prefix: -medoid_threshold
  - id: medoid_tree
    type:
      - 'null'
      - boolean
    doc: Use MedoidTree heuristic for speeding up tree construction
    inputBinding:
      position: 103
      prefix: -medoidtree
  - id: pid
    type:
      - 'null'
      - boolean
    doc: Generate pairwise identity instead of distance
    inputBinding:
      position: 103
      prefix: -pid
  - id: refine_mode
    type:
      - 'null'
      - string
    doc: Refinement mode (on | off | auto)
    inputBinding:
      position: 103
      prefix: -refine_mode
  - id: refinement_iterations
    type:
      - 'null'
      - int
    doc: No. of refinement iterations
    inputBinding:
      position: 103
      prefix: -r
  - id: remove_rare_columns
    type:
      - 'null'
      - float
    doc: Remove columns with less than <rare_column_threshold> fraction of 
      non-gap characters
    inputBinding:
      position: 103
      prefix: -remove-rare-columns
  - id: scoring_matrix
    type:
      - 'null'
      - string
    doc: Scoring matrix (MIQS | PFASUM31 | PFASUM43 | PFASUM60)
    inputBinding:
      position: 103
      prefix: -sm
  - id: square_matrix
    type:
      - 'null'
      - boolean
    doc: Generate a square distance matrix instead of a default triangle
    inputBinding:
      position: 103
      prefix: -square_matrix
  - id: terminal_gap_extension
    type:
      - 'null'
      - int
    doc: Terminal gap extension cost
    inputBinding:
      position: 103
      prefix: -tge
  - id: terminal_gap_open
    type:
      - 'null'
      - int
    doc: Terminal gap open cost
    inputBinding:
      position: 103
      prefix: -tgo
  - id: threads
    type:
      - 'null'
      - int
    doc: No. of threads. 0 indicates half of all logical cores.
    inputBinding:
      position: 103
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode, show timing information
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: output_file
    type: File
    doc: Output file (alignment, guide tree, or distance matrix). Pass STDOUT 
      for standard output.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/famsa:2.4.1--h9ee0642_0
