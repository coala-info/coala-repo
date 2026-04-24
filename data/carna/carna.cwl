cwlVersion: v1.2
class: CommandLineTool
baseCommand: carna
label: carna
doc: "A tool for pairwise Alignment of RNA.\n\nTool homepage: https://github.com/Code52/carnac"
inputs:
  - id: file1
    type: File
    doc: First RNA sequence file
    inputBinding:
      position: 1
  - id: file2
    type: File
    doc: Second RNA sequence file
    inputBinding:
      position: 2
  - id: expected_prob
    type:
      - 'null'
      - float
    doc: Expected probability
    inputBinding:
      position: 103
      prefix: --exp-prob
  - id: ignore_constraints
    type:
      - 'null'
      - boolean
    doc: Ignore constraints in pp-file
    inputBinding:
      position: 103
      prefix: --ignore-constraints
  - id: indel_opening_score
    type:
      - 'null'
      - int
    doc: Indel opening score
    inputBinding:
      position: 103
      prefix: --indel-opening
  - id: indel_score
    type:
      - 'null'
      - int
    doc: Indel score
    inputBinding:
      position: 103
      prefix: --indel
  - id: lower_score_bound
    type:
      - 'null'
      - float
    doc: Lower score bound
    inputBinding:
      position: 103
      prefix: --lb
  - id: match_score
    type:
      - 'null'
      - int
    doc: Match score
    inputBinding:
      position: 103
      prefix: --match
  - id: max_bp_span
    type:
      - 'null'
      - int
    doc: Limit maximum base pair span (default=off)
    inputBinding:
      position: 103
      prefix: --maxBPspan
  - id: max_bps_length_ratio
    type:
      - 'null'
      - float
    doc: 'Maximal ratio of #base pairs divided by sequence length (default: no effect)'
    inputBinding:
      position: 103
      prefix: --max-bps-length-ratio
  - id: max_diff
    type:
      - 'null'
      - int
    doc: Maximal difference for alignment cuts
    inputBinding:
      position: 103
      prefix: --max-diff
  - id: max_diff_am
    type:
      - 'null'
      - int
    doc: Maximal difference for sizes of matched arcs
    inputBinding:
      position: 103
      prefix: --max-diff-am
  - id: max_diff_at_am
    type:
      - 'null'
      - int
    doc: Maximal difference for alignment traces, only at arc match positions
    inputBinding:
      position: 103
      prefix: --max-diff-at-am
  - id: min_prob
    type:
      - 'null'
      - float
    doc: Minimal probability
    inputBinding:
      position: 103
      prefix: --min-prob
  - id: mismatch_score
    type:
      - 'null'
      - int
    doc: Mismatch score
    inputBinding:
      position: 103
      prefix: --mismatch
  - id: no_lp
    type:
      - 'null'
      - boolean
    doc: No lonely pairs (only used when predicing ensemble porobabilities and 
      for compatibility with locarna; otherwise no effect)
    inputBinding:
      position: 103
      prefix: --noLP
  - id: output_width
    type:
      - 'null'
      - int
    doc: Output width
    inputBinding:
      position: 103
      prefix: --width
  - id: recomputation_distance
    type:
      - 'null'
      - int
    doc: Recomputation distance
    inputBinding:
      position: 103
      prefix: --c_d
  - id: relaxed_anchors
    type:
      - 'null'
      - boolean
    doc: Relax anchor constraints (default=off)
    inputBinding:
      position: 103
      prefix: --relaxed-anchors
  - id: ribosum_file
    type:
      - 'null'
      - File
    doc: Ribosum file
    inputBinding:
      position: 103
      prefix: --ribosum-file
  - id: struct_weight
    type:
      - 'null'
      - int
    doc: Maximal weight of 1/2 arc match
    inputBinding:
      position: 103
      prefix: --struct-weight
  - id: tau_factor
    type:
      - 'null'
      - float
    doc: Tau factor in percent
    inputBinding:
      position: 103
      prefix: --tau
  - id: time_limit_ms
    type:
      - 'null'
      - int
    doc: Time limit in ms (always search first solution; turn off by 0).
    inputBinding:
      position: 103
      prefix: --time-limit
  - id: upper_score_bound
    type:
      - 'null'
      - float
    doc: Upper score bound
    inputBinding:
      position: 103
      prefix: --ub
  - id: use_gist
    type:
      - 'null'
      - boolean
    doc: Use gist for graphical search (feature disabled, recompile to 
      activate).
    inputBinding:
      position: 103
      prefix: --gist
  - id: use_ribosum
    type:
      - 'null'
      - boolean
    doc: Use ribosum scores
    inputBinding:
      position: 103
      prefix: --use-ribosum
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose
    inputBinding:
      position: 103
      prefix: --verbose
  - id: write_structure
    type:
      - 'null'
      - boolean
    doc: Write guidance structure in output
    inputBinding:
      position: 103
      prefix: --write-structure
outputs:
  - id: clustal_output_file
    type:
      - 'null'
      - File
    doc: Clustal output
    outputBinding:
      glob: $(inputs.clustal_output_file)
  - id: pp_output_file
    type:
      - 'null'
      - File
    doc: PP output
    outputBinding:
      glob: $(inputs.pp_output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/carna:1.3.3--1
