cwlVersion: v1.2
class: CommandLineTool
baseCommand: trimal
label: trimal
doc: "A tool for automated alignment trimming in large-scale phylogenetic analyses.\n
  \nTool homepage: https://trimal.readthedocs.io"
inputs:
  - id: alternative_matrix
    type:
      - 'null'
      - string
    doc: Select an alternative similarity matrix already loaded. Only available 'degenerated_nt_identity'
    inputBinding:
      position: 101
      prefix: --alternative_matrix
  - id: automated1
    type:
      - 'null'
      - boolean
    doc: Use a heuristic selection of the automatic method based on similarity statistics.
      (Optimized for Maximum Likelihood phylogenetic tree reconstruction).
    inputBinding:
      position: 101
      prefix: -automated1
  - id: back_trans
    type:
      - 'null'
      - File
    doc: Use a Coding Sequences file to get a backtranslation for a given AA alignment
    inputBinding:
      position: 101
      prefix: -backtrans
  - id: block_size
    type:
      - 'null'
      - int
    doc: Minimum column block size to be kept in the trimmed alignment. Available
      with manual and automatic (gappyout) methods
    inputBinding:
      position: 101
      prefix: -block
  - id: clusters
    type:
      - 'null'
      - int
    doc: Get the most Nth representatives sequences from a given alignment.
    inputBinding:
      position: 101
      prefix: -clusters
  - id: column_numbering
    type:
      - 'null'
      - boolean
    doc: Get the relationship between the columns in the old and new alignment.
    inputBinding:
      position: 101
      prefix: -colnumbering
  - id: compare_set
    type:
      - 'null'
      - File
    doc: Input list of paths for the files containing the alignments to compare.
    inputBinding:
      position: 101
      prefix: -compareset
  - id: complementary
    type:
      - 'null'
      - boolean
    doc: Get the complementary alignment.
    inputBinding:
      position: 101
      prefix: -complementary
  - id: conserve_percentage
    type:
      - 'null'
      - float
    doc: 'Minimum percentage of the positions in the original alignment to conserve.
      Range: [0 - 100]'
    inputBinding:
      position: 101
      prefix: -cons
  - id: consistency_threshold
    type:
      - 'null'
      - float
    doc: 'Minimum consistency value allowed. Range: [0 - 1]'
    inputBinding:
      position: 101
      prefix: -conthreshold
  - id: consistency_window_size
    type:
      - 'null'
      - int
    doc: (half) Window size only applies to statistics/methods based on Consistency.
    inputBinding:
      position: 101
      prefix: -cw
  - id: force_select
    type:
      - 'null'
      - File
    doc: Force selection of the given input file in the files comparison method.
    inputBinding:
      position: 101
      prefix: -forceselect
  - id: gap_threshold
    type:
      - 'null'
      - float
    doc: '1 - (fraction of sequences with a gap allowed). Range: [0 - 1]'
    inputBinding:
      position: 101
      prefix: -gapthreshold
  - id: gap_window_size
    type:
      - 'null'
      - int
    doc: (half) Window size only applies to statistics/methods based on Gaps.
    inputBinding:
      position: 101
      prefix: -gw
  - id: gappy_out
    type:
      - 'null'
      - boolean
    doc: Use automated selection on 'gappyout' mode. This method only uses information
      based on gaps' distribution.
    inputBinding:
      position: 101
      prefix: -gappyout
  - id: ignore_stop_codon
    type:
      - 'null'
      - boolean
    doc: Ignore stop codons in the input coding sequences
    inputBinding:
      position: 101
      prefix: -ignorestopcodon
  - id: input_file
    type: File
    doc: Input file in several formats (clustal, fasta, NBRF/PIR, nexus, phylip3.2,
      phylip).
    inputBinding:
      position: 101
      prefix: -in
  - id: keep_header
    type:
      - 'null'
      - boolean
    doc: Keep original sequence header including non-alphanumeric characters. Only
      available for input FASTA format files.
    inputBinding:
      position: 101
      prefix: -keepheader
  - id: keep_seqs
    type:
      - 'null'
      - boolean
    doc: Keep sequences even if they are composed only by gaps.
    inputBinding:
      position: 101
      prefix: -keepseqs
  - id: matrix
    type:
      - 'null'
      - File
    doc: Input file for user-defined similarity matrix (default is Blosum62).
    inputBinding:
      position: 101
      prefix: -matrix
  - id: max_identity
    type:
      - 'null'
      - float
    doc: 'Get the representatives sequences for a given identity threshold. Range:
      [0 - 1].'
    inputBinding:
      position: 101
      prefix: -maxidentity
  - id: no_all_gaps
    type:
      - 'null'
      - boolean
    doc: Remove columns composed only by gaps.
    inputBinding:
      position: 101
      prefix: -noallgaps
  - id: no_gaps
    type:
      - 'null'
      - boolean
    doc: Remove all positions with gaps in the alignment.
    inputBinding:
      position: 101
      prefix: -nogaps
  - id: output_clustal
    type:
      - 'null'
      - boolean
    doc: Output file in CLUSTAL format
    inputBinding:
      position: 101
      prefix: -clustal
  - id: output_fasta
    type:
      - 'null'
      - boolean
    doc: Output file in FASTA format
    inputBinding:
      position: 101
      prefix: -fasta
  - id: output_fasta_m10
    type:
      - 'null'
      - boolean
    doc: Output file in FASTA format. Sequences name length up to 10 characters.
    inputBinding:
      position: 101
      prefix: -fasta_m10
  - id: output_mega
    type:
      - 'null'
      - boolean
    doc: Output file in MEGA format
    inputBinding:
      position: 101
      prefix: -mega
  - id: output_nbrf
    type:
      - 'null'
      - boolean
    doc: Output file in NBRF/PIR format
    inputBinding:
      position: 101
      prefix: -nbrf
  - id: output_nexus
    type:
      - 'null'
      - boolean
    doc: Output file in NEXUS format
    inputBinding:
      position: 101
      prefix: -nexus
  - id: output_phylip
    type:
      - 'null'
      - boolean
    doc: Output file in PHYLIP/PHYLIP4 format
    inputBinding:
      position: 101
      prefix: -phylip
  - id: output_phylip32
    type:
      - 'null'
      - boolean
    doc: Output file in PHYLIP3.2 format
    inputBinding:
      position: 101
      prefix: -phylip3.2
  - id: output_phylip32_m10
    type:
      - 'null'
      - boolean
    doc: Output file in PHYLIP3.2 format. Sequences name length up to 10 characters.
    inputBinding:
      position: 101
      prefix: -phylip3.2_m10
  - id: output_phylip_m10
    type:
      - 'null'
      - boolean
    doc: Output file in PHYLIP/PHYLIP4 format. Sequences name length up to 10 characters.
    inputBinding:
      position: 101
      prefix: -phylip_m10
  - id: output_phylip_paml
    type:
      - 'null'
      - boolean
    doc: Output file in PHYLIP format compatible with PAML
    inputBinding:
      position: 101
      prefix: -phylip_paml
  - id: output_phylip_paml_m10
    type:
      - 'null'
      - boolean
    doc: Output file in PHYLIP format compatible with PAML. Sequences name length
      up to 10 characters.
    inputBinding:
      position: 101
      prefix: -phylip_paml_m10
  - id: print_gap_scores_accumulated
    type:
      - 'null'
      - boolean
    doc: Print accumulated gap scores for the input alignment.
    inputBinding:
      position: 101
      prefix: -sgt
  - id: print_gap_scores_column
    type:
      - 'null'
      - boolean
    doc: Print gap scores for each column in the input alignment.
    inputBinding:
      position: 101
      prefix: -sgc
  - id: print_identity_matrix
    type:
      - 'null'
      - boolean
    doc: Print identity scores matrix for all sequences in the input alignment.
    inputBinding:
      position: 101
      prefix: -sident
  - id: print_overlap_matrix
    type:
      - 'null'
      - boolean
    doc: Print overlap scores matrix for all sequences in the input alignment.
    inputBinding:
      position: 101
      prefix: -soverlap
  - id: print_similarity_scores_accumulated
    type:
      - 'null'
      - boolean
    doc: Print accumulated similarity scores for the input alignment.
    inputBinding:
      position: 101
      prefix: -sst
  - id: print_similarity_scores_column
    type:
      - 'null'
      - boolean
    doc: Print similarity scores for each column in the input alignment.
    inputBinding:
      position: 101
      prefix: -ssc
  - id: print_sum_of_pairs_accumulated
    type:
      - 'null'
      - boolean
    doc: Print accumulated sum-of-pairs scores for the selected alignment
    inputBinding:
      position: 101
      prefix: -sft
  - id: print_sum_of_pairs_column
    type:
      - 'null'
      - boolean
    doc: Print sum-of-pairs scores for each column from the selected alignment
    inputBinding:
      position: 101
      prefix: -sfc
  - id: residue_overlap
    type:
      - 'null'
      - float
    doc: "Minimum overlap of a positions with other positions in the column to be
      considered a 'good position'. Range: [0 - 1]."
    inputBinding:
      position: 101
      prefix: -resoverlap
  - id: select_cols
    type:
      - 'null'
      - string
    doc: 'Selection of columns to be removed from the alignment. Range: [0 - (Number
      of Columns - 1)]. Format: { n,l,m-k }'
    inputBinding:
      position: 101
      prefix: -selectcols
  - id: select_seqs
    type:
      - 'null'
      - string
    doc: 'Selection of sequences to be removed from the alignment. Range: [0 - (Number
      of Sequences - 1)]. Format: { n,l,m-k }'
    inputBinding:
      position: 101
      prefix: -selectseqs
  - id: sequence_overlap
    type:
      - 'null'
      - float
    doc: "Minimum percentage of 'good positions' that a sequence must have in order
      to be conserved. Range: [0 - 100]"
    inputBinding:
      position: 101
      prefix: -seqoverlap
  - id: set_boundaries
    type:
      - 'null'
      - string
    doc: 'Set manually left (l) and right (r) boundaries. Format: { l,r }'
    inputBinding:
      position: 101
      prefix: --set_boundaries
  - id: similarity_threshold
    type:
      - 'null'
      - float
    doc: 'Minimum average similarity allowed. Range: [0 - 1]'
    inputBinding:
      position: 101
      prefix: -simthreshold
  - id: similarity_window_size
    type:
      - 'null'
      - int
    doc: (half) Window size only applies to statistics/methods based on Similarity.
    inputBinding:
      position: 101
      prefix: -sw
  - id: split_by_stop_codon
    type:
      - 'null'
      - boolean
    doc: Split input coding sequences up to first stop codon appearance
    inputBinding:
      position: 101
      prefix: -splitbystopcodon
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Use automated selection on 'strict' mode.
    inputBinding:
      position: 101
      prefix: -strict
  - id: strict_plus
    type:
      - 'null'
      - boolean
    doc: Use automated selection on 'strictplus' mode. (Optimized for Neighbour Joining
      phylogenetic tree reconstruction).
    inputBinding:
      position: 101
      prefix: -strictplus
  - id: terminal_only
    type:
      - 'null'
      - boolean
    doc: Only columns out of internal boundaries (first and last column without gaps)
      are candidates to be trimmed depending on the selected method
    inputBinding:
      position: 101
      prefix: -terminalonly
  - id: window_size
    type:
      - 'null'
      - int
    doc: (half) Window size, score of position i is the average of the window (i -
      n) to (i + n).
    inputBinding:
      position: 101
      prefix: -w
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output alignment in the same input format (default stdout).
    outputBinding:
      glob: $(inputs.output_file)
  - id: html_output
    type:
      - 'null'
      - File
    doc: Get a summary of trimal's work in an HTML file.
    outputBinding:
      glob: $(inputs.html_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trimal:1.5.1--h9948957_0
