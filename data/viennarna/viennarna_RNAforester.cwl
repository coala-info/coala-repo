cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RNAforester
label: viennarna_RNAforester
doc: |-
  Compare RNA secondary structures via forest alignment: pairwise or multiple alignment, structure prediction from alignment, profile search.

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: input_file
    type: File
    doc: Read input (sequences with dot-bracket structures in Vienna format) from this file.
    inputBinding:
      position: 1
      prefix: -f=
      separate: false
  - id: score
    type:
      - 'null'
      - boolean
    doc: Compute only scores, no alignment.
    inputBinding:
      position: 2
      prefix: --score
  - id: noscale
    type:
      - 'null'
      - boolean
    doc: Suppress output of scale.
    inputBinding:
      position: 2
      prefix: --noscale
  - id: tables
    type:
      - 'null'
      - boolean
    doc: Show dynamic programming tables.
    inputBinding:
      position: 2
      prefix: --tables
  - id: backtrace
    type:
      - 'null'
      - boolean
    doc: Show backtrace call table cells.
    inputBinding:
      position: 2
      prefix: --backtrace
  - id: top_down
    type:
      - 'null'
      - boolean
    doc: Calculate the alignment top down instead of bottom up.
    inputBinding:
      position: 2
      prefix: -t
  - id: distance
    type:
      - 'null'
      - boolean
    doc: Calculate distance instead of similarity.
    inputBinding:
      position: 2
      prefix: -d
  - id: relative_score
    type:
      - 'null'
      - boolean
    doc: Calculate relative score.
    inputBinding:
      position: 2
      prefix: -r
  - id: local_similarity
    type:
      - 'null'
      - boolean
    doc: Local similarity.
    inputBinding:
      position: 2
      prefix: -l
  - id: local_suboptimal
    type:
      - 'null'
      - int
    doc: Local suboptimal alignments within this percentage.
    inputBinding:
      position: 2
      prefix: -so=
      separate: false
  - id: small_in_large
    type:
      - 'null'
      - boolean
    doc: Small-in-large similarity.
    inputBinding:
      position: 2
      prefix: -s
  - id: anchor
    type:
      - 'null'
      - boolean
    doc: Use shape anchoring for speedup.
    inputBinding:
      position: 2
      prefix: --anchor
  - id: affine_gap
    type:
      - 'null'
      - boolean
    doc: Affine gap scoring.
    inputBinding:
      position: 2
      prefix: -a
  - id: multiple
    type:
      - 'null'
      - boolean
    doc: Multiple alignment mode.
    inputBinding:
      position: 2
      prefix: -m
  - id: ribosum
    type:
      - 'null'
      - boolean
    doc: Use the RIBOSUM85-60 scoring matrix (base-pair substitutions).
    inputBinding:
      position: 2
      prefix: --RIBOSUM
  - id: consensus_base_min
    type:
      - 'null'
      - float
    doc: Minimum base frequency for the consensus structure.
    inputBinding:
      position: 2
      prefix: -cbmin=
      separate: false
  - id: consensus_pair_min
    type:
      - 'null'
      - float
    doc: Minimum base pair frequency for the consensus structure.
    inputBinding:
      position: 2
      prefix: -cmin=
      separate: false
  - id: cluster_threshold
    type:
      - 'null'
      - float
    doc: Clustering threshold.
    inputBinding:
      position: 2
      prefix: -mt=
      separate: false
  - id: cluster_cutoff
    type:
      - 'null'
      - float
    doc: Clustering cutoff.
    inputBinding:
      position: 2
      prefix: -mc=
      separate: false
  - id: predict
    type:
      - 'null'
      - boolean
    doc: Predict structures from sequences.
    inputBinding:
      position: 2
      prefix: -p
  - id: predict_pair_min
    type:
      - 'null'
      - float
    doc: Minimum base pair frequency for prediction.
    inputBinding:
      position: 2
      prefix: -pmin=
      separate: false
  - id: save_profile
    type:
      - 'null'
      - string
    doc: Save the profile to this file name.
    inputBinding:
      position: 2
      prefix: -sp=
      separate: false
  - id: profile_search
    type:
      - 'null'
      - File
    doc: Profile file to search with.
    inputBinding:
      position: 2
      prefix: -ps=
      separate: false
  - id: pair_match
    type:
      - 'null'
      - int
    doc: Base pair (bond) match score.
    inputBinding:
      position: 2
      prefix: -pm=
      separate: false
  - id: pair_indel
    type:
      - 'null'
      - int
    doc: Base pair bond indel score.
    inputBinding:
      position: 2
      prefix: -pd=
      separate: false
  - id: pair_indel_open
    type:
      - 'null'
      - int
    doc: Base pair bond indel open score.
    inputBinding:
      position: 2
      prefix: -pdo=
      separate: false
  - id: base_match
    type:
      - 'null'
      - int
    doc: Base match score.
    inputBinding:
      position: 2
      prefix: -bm=
      separate: false
  - id: base_mismatch
    type:
      - 'null'
      - int
    doc: Base mismatch score.
    inputBinding:
      position: 2
      prefix: -br=
      separate: false
  - id: base_indel
    type:
      - 'null'
      - int
    doc: Base indel score.
    inputBinding:
      position: 2
      prefix: -bd=
      separate: false
  - id: base_indel_open
    type:
      - 'null'
      - int
    doc: Base indel open score.
    inputBinding:
      position: 2
      prefix: -bdo=
      separate: false
  - id: plot_2d
    type:
      - 'null'
      - boolean
    doc: Generate alignment 2D plots in PostScript format.
    inputBinding:
      position: 2
      prefix: -2d
  - id: hide_base_numbers
    type:
      - 'null'
      - boolean
    doc: Hide base numbers in the 2D plot.
    inputBinding:
      position: 2
      prefix: --2d_hidebasenum
  - id: base_number_interval
    type:
      - 'null'
      - int
    doc: Show every n-th base number in the 2D plot.
    inputBinding:
      position: 2
      prefix: --2d_basenuminterval=
      separate: false
  - id: grey
    type:
      - 'null'
      - boolean
    doc: Use only grey colors in 2D plots.
    inputBinding:
      position: 2
      prefix: --2d_grey
  - id: scale_2d
    type:
      - 'null'
      - float
    doc: Scale factor for the 2D plots.
    inputBinding:
      position: 2
      prefix: --2d_scale=
      separate: false
  - id: fig
    type:
      - 'null'
      - boolean
    doc: Generate an additional fig file of the 2D plot.
    inputBinding:
      position: 2
      prefix: --2d_fig
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Generate FASTA output of alignments.
    inputBinding:
      position: 2
      prefix: --fasta
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
  - id: ps_files
    type:
      type: array
      items: File
    doc: 2D alignment plots in PostScript format
    outputBinding:
      glob:
        - '*.ps'
  - id: fig_files
    type:
      type: array
      items: File
    doc: 2D alignment plots in fig format
    outputBinding:
      glob:
        - '*.fig'
  - id: profile
    type:
      - 'null'
      - File
    doc: Saved profile
    outputBinding:
      glob: $(inputs.save_profile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdout: RNAforester.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
