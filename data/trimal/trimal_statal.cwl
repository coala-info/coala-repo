cwlVersion: v1.2
class: CommandLineTool
baseCommand: statal
label: trimal_statal
doc: "Compute alignment statistics: gap, similarity, consistency and identity scores (statAl, part of trimAl).\n\nTool homepage: https://trimal.readthedocs.io"
inputs:
  - id: input_file
    type: File
    doc: "Input file in several formats (clustal, fasta, nexus, phylip, etc)."
    inputBinding:
      position: 1
      prefix: -in
  - id: compare_set
    type:
      - 'null'
      - File
    doc: "Input list of paths for the alignments to compare."
    inputBinding:
      position: 1
      prefix: -compareset
  - id: force_select
    type:
      - 'null'
      - File
    doc: "Force selection of a given file as reference for being compared with others."
    inputBinding:
      position: 1
      prefix: -forceselect
  - id: matrix
    type:
      - 'null'
      - File
    doc: "Input file for user-defined similarity matrix (default: Blosum62)."
    inputBinding:
      position: 1
      prefix: -matrix
  - id: alternative_matrix
    type:
      - 'null'
      - string
    doc: "Select an alternative similarity matrix already loaded. Only available 'degenerated_nt_identity'"
    inputBinding:
      position: 1
      prefix: --alternative_matrix
  - id: gap_scores_column
    type:
      - 'null'
      - boolean
    doc: "Print gap score per column from input alignment."
    inputBinding:
      position: 2
      prefix: -sgc
  - id: gap_scores_accumulated
    type:
      - 'null'
      - boolean
    doc: "Print accumulated gap scores distribution from input alignment."
    inputBinding:
      position: 2
      prefix: -sgt
  - id: similarity_scores_column
    type:
      - 'null'
      - boolean
    doc: "Print similarity score per column from input alignment."
    inputBinding:
      position: 2
      prefix: -ssc
  - id: similarity_scores_accumulated
    type:
      - 'null'
      - boolean
    doc: "Print accumulated similarity scores distribution for input alignment."
    inputBinding:
      position: 2
      prefix: -sst
  - id: sum_of_pairs_column
    type:
      - 'null'
      - boolean
    doc: "Print sum-of-pairs score per column for the selected alignment"
    inputBinding:
      position: 2
      prefix: -sfc
  - id: sum_of_pairs_accumulated
    type:
      - 'null'
      - boolean
    doc: "Print accumulated sum-of-pairs scores distribution for the selected alignment"
    inputBinding:
      position: 2
      prefix: -sft
  - id: identity_scores
    type:
      - 'null'
      - boolean
    doc: "Print identity scores for sequences in the alignment."
    inputBinding:
      position: 2
      prefix: -sident
  - id: column_identity_stats
    type:
      - 'null'
      - boolean
    doc: "Print general descriptive statistics for column identity scores from input alignment."
    inputBinding:
      position: 2
      prefix: -scolidentt
  - id: window_size
    type:
      - 'null'
      - int
    doc: "(half) Window size, score of position i is the average of the window (i - n) to (i + n)."
    inputBinding:
      position: 2
      prefix: -w
  - id: gap_window_size
    type:
      - 'null'
      - int
    doc: "(half) Window size only applies to statistics based on Gaps."
    inputBinding:
      position: 2
      prefix: -gw
  - id: similarity_window_size
    type:
      - 'null'
      - int
    doc: "(half) Window size only applies to statistics based on Similarity."
    inputBinding:
      position: 2
      prefix: -sw
  - id: consistency_window_size
    type:
      - 'null'
      - int
    doc: "(half) Window size only applies to statistics based on Consistency."
    inputBinding:
      position: 2
      prefix: -cw
outputs:
  - id: stdout
    type: stdout
    doc: "Statistics printed to the console"
stdout: trimal_statal.out
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trimal:1.5.1--h9948957_0
