cwlVersion: v1.2
class: CommandLineTool
baseCommand: blastall
label: blast-legacy_blastall
doc: "Legacy BLAST search tool\n\nTool homepage: http://blast.ncbi.nlm.nih.gov"
inputs:
  - id: alignment_view
    type:
      - 'null'
      - int
    doc: 'alignment view options: 0 = pairwise, 1 = query-anchored showing identities,
      2 = query-anchored no identities, 3 = flat query-anchored, show identities,
      4 = flat query-anchored, no identities, 5 = query-anchored no identities and
      blunt ends, 6 = flat query-anchored, no identities and blunt ends, 7 = XML Blast
      output, 8 = tabular, 9 tabular with comment lines, 10 ASN, text, 11 ASN, binary'
    default: 0
    inputBinding:
      position: 101
      prefix: -m
  - id: alignments_count
    type:
      - 'null'
      - int
    doc: Number of database sequence to show alignments for (B)
    default: 250
    inputBinding:
      position: 101
      prefix: -b
  - id: believe_query_defline
    type:
      - 'null'
      - boolean
    doc: Believe the query defline
    default: false
    inputBinding:
      position: 101
      prefix: -J
  - id: best_hits_to_keep
    type:
      - 'null'
      - int
    doc: Number of best hits from a region to keep. Off by default.
    default: 0
    inputBinding:
      position: 101
      prefix: -K
  - id: composition_based_stats
    type:
      - 'null'
      - string
    doc: Use composition-based score adjustments for blastp or tblastn
    default: D
    inputBinding:
      position: 101
      prefix: -C
  - id: concatenated_queries
    type:
      - 'null'
      - int
    doc: Number of concatenated queries, for blastn and tblastn
    default: 0
    inputBinding:
      position: 101
      prefix: -B
  - id: database
    type:
      - 'null'
      - string
    doc: Database
    default: nr
    inputBinding:
      position: 101
      prefix: -d
  - id: db_genetic_code
    type:
      - 'null'
      - int
    doc: DB Genetic code (for tblast[nx] only)
    default: 1
    inputBinding:
      position: 101
      prefix: -D
  - id: descriptions_count
    type:
      - 'null'
      - int
    doc: Number of database sequences to show one-line descriptions for (V)
    default: 500
    inputBinding:
      position: 101
      prefix: -v
  - id: effective_db_length
    type:
      - 'null'
      - float
    doc: Effective length of the database (use zero for the real size)
    default: 0
    inputBinding:
      position: 101
      prefix: -z
  - id: effective_search_space
    type:
      - 'null'
      - float
    doc: Effective length of the search space (use zero for the real size)
    default: 0
    inputBinding:
      position: 101
      prefix: -Y
  - id: expectation_value
    type:
      - 'null'
      - float
    doc: Expectation value (E)
    default: 10.0
    inputBinding:
      position: 101
      prefix: -e
  - id: filter_query
    type:
      - 'null'
      - string
    doc: Filter query sequence (DUST with blastn, SEG with others)
    default: T
    inputBinding:
      position: 101
      prefix: -F
  - id: force_legacy_engine
    type:
      - 'null'
      - boolean
    doc: Force use of the legacy BLAST engine
    default: false
    inputBinding:
      position: 101
      prefix: -V
  - id: frame_shift_penalty
    type:
      - 'null'
      - int
    doc: Frame shift penalty (OOF algorithm for blastx)
    default: 0
    inputBinding:
      position: 101
      prefix: -w
  - id: gap_extend_cost
    type:
      - 'null'
      - int
    doc: Cost to extend a gap (-1 invokes default behavior)
    default: -1
    inputBinding:
      position: 101
      prefix: -E
  - id: gap_open_cost
    type:
      - 'null'
      - int
    doc: Cost to open a gap (-1 invokes default behavior)
    default: -1
    inputBinding:
      position: 101
      prefix: -G
  - id: gapped_alignment
    type:
      - 'null'
      - boolean
    doc: Perform gapped alignment (not available with tblastx)
    default: true
    inputBinding:
      position: 101
      prefix: -g
  - id: gi_list_restriction
    type:
      - 'null'
      - string
    doc: Restrict search of database to list of GI's
    inputBinding:
      position: 101
      prefix: -l
  - id: html_output
    type:
      - 'null'
      - boolean
    doc: Produce HTML output
    default: false
    inputBinding:
      position: 101
      prefix: -T
  - id: lower_case_filtering
    type:
      - 'null'
      - boolean
    doc: Use lower case filtering of FASTA sequence
    inputBinding:
      position: 101
      prefix: -U
  - id: match_reward
    type:
      - 'null'
      - int
    doc: Reward for a nucleotide match (blastn only)
    default: 1
    inputBinding:
      position: 101
      prefix: -r
  - id: matrix
    type:
      - 'null'
      - string
    doc: Matrix
    default: BLOSUM62
    inputBinding:
      position: 101
      prefix: -M
  - id: max_intron_length
    type:
      - 'null'
      - int
    doc: Length of the largest intron allowed in a translated nucleotide sequence
      when linking multiple distinct alignments.
    default: 0
    inputBinding:
      position: 101
      prefix: -t
  - id: megablast_search
    type:
      - 'null'
      - boolean
    doc: MegaBlast search
    default: false
    inputBinding:
      position: 101
      prefix: -n
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: Penalty for a nucleotide mismatch (blastn only)
    default: -3
    inputBinding:
      position: 101
      prefix: -q
  - id: multiple_hit_mode
    type:
      - 'null'
      - int
    doc: 0 for multiple hit, 1 for single hit (does not apply to blastn)
    default: 0
    inputBinding:
      position: 101
      prefix: -P
  - id: multiple_hits_window
    type:
      - 'null'
      - int
    doc: Multiple Hits window size, default if zero
    default: 0
    inputBinding:
      position: 101
      prefix: -A
  - id: num_processors
    type:
      - 'null'
      - int
    doc: Number of processors to use
    default: 1
    inputBinding:
      position: 101
      prefix: -a
  - id: program
    type: string
    doc: Program Name
    inputBinding:
      position: 101
      prefix: -p
  - id: psi_tblastn_checkpoint
    type:
      - 'null'
      - File
    doc: PSI-TBLASTN checkpoint file
    inputBinding:
      position: 101
      prefix: -R
  - id: query_file
    type:
      - 'null'
      - File
    doc: Query File
    default: stdin
    inputBinding:
      position: 101
      prefix: -i
  - id: query_genetic_code
    type:
      - 'null'
      - int
    doc: Query Genetic code to use
    default: 1
    inputBinding:
      position: 101
      prefix: -Q
  - id: query_location
    type:
      - 'null'
      - string
    doc: Location on query sequence
    inputBinding:
      position: 101
      prefix: -L
  - id: query_strands
    type:
      - 'null'
      - int
    doc: Query strands to search against database (for blast[nx], and tblastx). 3
      is both, 1 is top, 2 is bottom
    default: 3
    inputBinding:
      position: 101
      prefix: -S
  - id: show_gi
    type:
      - 'null'
      - boolean
    doc: Show GI's in deflines
    default: false
    inputBinding:
      position: 101
      prefix: -I
  - id: smith_waterman_alignments
    type:
      - 'null'
      - boolean
    doc: Compute locally optimal Smith-Waterman alignments (This option is only available
      for gapped tblastn.)
    default: false
    inputBinding:
      position: 101
      prefix: -s
  - id: threshold_extending_hits
    type:
      - 'null'
      - float
    doc: Threshold for extending hits, default if zero
    default: 0
    inputBinding:
      position: 101
      prefix: -f
  - id: word_size
    type:
      - 'null'
      - int
    doc: Word size, default if zero
    default: 0
    inputBinding:
      position: 101
      prefix: -W
  - id: x_dropoff_final_gapped
    type:
      - 'null'
      - int
    doc: X dropoff value for final gapped alignment in bits (0.0 invokes default behavior)
    default: 0
    inputBinding:
      position: 101
      prefix: -Z
  - id: x_dropoff_gapped
    type:
      - 'null'
      - int
    doc: X dropoff value for gapped alignment (in bits) (zero invokes default behavior)
    default: 0
    inputBinding:
      position: 101
      prefix: -X
  - id: x_dropoff_ungapped
    type:
      - 'null'
      - float
    doc: X dropoff value for ungapped extensions in bits (0.0 invokes default behavior)
    default: 0.0
    inputBinding:
      position: 101
      prefix: -y
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: BLAST report Output File
    outputBinding:
      glob: $(inputs.output_file)
  - id: seqalign_file
    type:
      - 'null'
      - File
    doc: SeqAlign file
    outputBinding:
      glob: $(inputs.seqalign_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blast-legacy:2.2.26--h9ee0642_3
