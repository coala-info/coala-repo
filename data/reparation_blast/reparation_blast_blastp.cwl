cwlVersion: v1.2
class: CommandLineTool
baseCommand: blastp
label: reparation_blast_blastp
doc: "Protein-Protein BLAST 2.7.1+\n\nTool homepage: https://github.com/RickGelhausen/REPARATION_blast"
inputs:
  - id: best_hit_overhang
    type:
      - 'null'
      - float
    doc: 'Best Hit algorithm overhang value (recommended value: 0.1)'
    inputBinding:
      position: 101
      prefix: -best_hit_overhang
  - id: best_hit_score_edge
    type:
      - 'null'
      - float
    doc: 'Best Hit algorithm score edge value (recommended value: 0.1)'
    inputBinding:
      position: 101
      prefix: -best_hit_score_edge
  - id: comp_based_stats
    type:
      - 'null'
      - string
    doc: Use composition-based statistics
    default: '2'
    inputBinding:
      position: 101
      prefix: -comp_based_stats
  - id: culling_limit
    type:
      - 'null'
      - int
    doc: If the query range of a hit is enveloped by that of at least this many 
      higher-scoring hits, delete the hit
    inputBinding:
      position: 101
      prefix: -culling_limit
  - id: db
    type:
      - 'null'
      - string
    doc: BLAST database name
    inputBinding:
      position: 101
      prefix: -db
  - id: db_hard_mask
    type:
      - 'null'
      - string
    doc: Filtering algorithm ID to apply to the BLAST database as hard masking
    inputBinding:
      position: 101
      prefix: -db_hard_mask
  - id: db_soft_mask
    type:
      - 'null'
      - string
    doc: Filtering algorithm ID to apply to the BLAST database as soft masking
    inputBinding:
      position: 101
      prefix: -db_soft_mask
  - id: dbsize
    type:
      - 'null'
      - int
    doc: Effective length of the database
    inputBinding:
      position: 101
      prefix: -dbsize
  - id: entrez_query
    type:
      - 'null'
      - string
    doc: Restrict search with the given Entrez query
    inputBinding:
      position: 101
      prefix: -entrez_query
  - id: evalue
    type:
      - 'null'
      - float
    doc: Expectation value (E) threshold for saving hits
    default: 10.0
    inputBinding:
      position: 101
      prefix: -evalue
  - id: gapextend
    type:
      - 'null'
      - int
    doc: Cost to extend a gap
    inputBinding:
      position: 101
      prefix: -gapextend
  - id: gapopen
    type:
      - 'null'
      - int
    doc: Cost to open a gap
    inputBinding:
      position: 101
      prefix: -gapopen
  - id: gilist
    type:
      - 'null'
      - File
    doc: Restrict search of database to list of GI's
    inputBinding:
      position: 101
      prefix: -gilist
  - id: html
    type:
      - 'null'
      - boolean
    doc: Produce HTML output?
    inputBinding:
      position: 101
      prefix: -html
  - id: import_search_strategy
    type:
      - 'null'
      - File
    doc: Search strategy to use
    inputBinding:
      position: 101
      prefix: -import_search_strategy
  - id: lcase_masking
    type:
      - 'null'
      - boolean
    doc: Use lower case filtering in query and subject sequence(s)?
    inputBinding:
      position: 101
      prefix: -lcase_masking
  - id: line_length
    type:
      - 'null'
      - int
    doc: Line length for formatting alignments
    default: 60
    inputBinding:
      position: 101
      prefix: -line_length
  - id: matrix
    type:
      - 'null'
      - string
    doc: Scoring matrix name (normally BLOSUM62)
    inputBinding:
      position: 101
      prefix: -matrix
  - id: max_hsps
    type:
      - 'null'
      - int
    doc: Set maximum number of HSPs per subject sequence to save for each query
    inputBinding:
      position: 101
      prefix: -max_hsps
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: Maximum number of aligned sequences to keep
    default: 500
    inputBinding:
      position: 101
      prefix: -max_target_seqs
  - id: negative_gilist
    type:
      - 'null'
      - File
    doc: Restrict search of database to everything except the listed GIs
    inputBinding:
      position: 101
      prefix: -negative_gilist
  - id: negative_seqidlist
    type:
      - 'null'
      - File
    doc: Restrict search of database to everything except the listed SeqIDs
    inputBinding:
      position: 101
      prefix: -negative_seqidlist
  - id: num_alignments
    type:
      - 'null'
      - int
    doc: Number of database sequences to show alignments for
    default: 250
    inputBinding:
      position: 101
      prefix: -num_alignments
  - id: num_descriptions
    type:
      - 'null'
      - int
    doc: Number of database sequences to show one-line descriptions for
    default: 500
    inputBinding:
      position: 101
      prefix: -num_descriptions
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads (CPUs) to use in the BLAST search
    default: 1
    inputBinding:
      position: 101
      prefix: -num_threads
  - id: outfmt
    type:
      - 'null'
      - string
    doc: alignment view options
    default: '0'
    inputBinding:
      position: 101
      prefix: -outfmt
  - id: parse_deflines
    type:
      - 'null'
      - boolean
    doc: Should the query and subject defline(s) be parsed?
    inputBinding:
      position: 101
      prefix: -parse_deflines
  - id: qcov_hsp_perc
    type:
      - 'null'
      - float
    doc: Percent query coverage per hsp
    inputBinding:
      position: 101
      prefix: -qcov_hsp_perc
  - id: query
    type:
      - 'null'
      - File
    doc: Input file name
    inputBinding:
      position: 101
      prefix: -query
  - id: query_loc
    type:
      - 'null'
      - string
    doc: 'Location on the query sequence in 1-based offsets (Format: start-stop)'
    inputBinding:
      position: 101
      prefix: -query_loc
  - id: remote
    type:
      - 'null'
      - boolean
    doc: Execute search remotely?
    inputBinding:
      position: 101
      prefix: -remote
  - id: searchsp
    type:
      - 'null'
      - int
    doc: Effective length of the search space
    inputBinding:
      position: 101
      prefix: -searchsp
  - id: seg
    type:
      - 'null'
      - string
    doc: "Filter query sequence with SEG (Format: 'yes', 'window locut hicut', or
      'no' to disable)"
    default: no
    inputBinding:
      position: 101
      prefix: -seg
  - id: seqidlist
    type:
      - 'null'
      - File
    doc: Restrict search of database to list of SeqId's
    inputBinding:
      position: 101
      prefix: -seqidlist
  - id: show_gis
    type:
      - 'null'
      - boolean
    doc: Show NCBI GIs in deflines?
    inputBinding:
      position: 101
      prefix: -show_gis
  - id: soft_masking
    type:
      - 'null'
      - boolean
    doc: Apply filtering locations as soft masks
    default: false
    inputBinding:
      position: 101
      prefix: -soft_masking
  - id: subject
    type:
      - 'null'
      - File
    doc: Subject sequence(s) to search
    inputBinding:
      position: 101
      prefix: -subject
  - id: subject_loc
    type:
      - 'null'
      - string
    doc: 'Location on the subject sequence in 1-based offsets (Format: start-stop)'
    inputBinding:
      position: 101
      prefix: -subject_loc
  - id: sum_stats
    type:
      - 'null'
      - boolean
    doc: Use sum statistics
    inputBinding:
      position: 101
      prefix: -sum_stats
  - id: task
    type:
      - 'null'
      - string
    doc: Task to execute
    default: blastp
    inputBinding:
      position: 101
      prefix: -task
  - id: threshold
    type:
      - 'null'
      - float
    doc: Minimum word score such that the word is added to the BLAST lookup 
      table
    inputBinding:
      position: 101
      prefix: -threshold
  - id: ungapped
    type:
      - 'null'
      - boolean
    doc: Perform ungapped alignment only?
    inputBinding:
      position: 101
      prefix: -ungapped
  - id: use_sw_tback
    type:
      - 'null'
      - boolean
    doc: Compute locally optimal Smith-Waterman alignments?
    inputBinding:
      position: 101
      prefix: -use_sw_tback
  - id: window_size
    type:
      - 'null'
      - int
    doc: Multiple hits window size, use 0 to specify 1-hit algorithm
    inputBinding:
      position: 101
      prefix: -window_size
  - id: word_size
    type:
      - 'null'
      - int
    doc: Word size for wordfinder algorithm
    inputBinding:
      position: 101
      prefix: -word_size
  - id: xdrop_gap
    type:
      - 'null'
      - float
    doc: X-dropoff value (in bits) for preliminary gapped extensions
    inputBinding:
      position: 101
      prefix: -xdrop_gap
  - id: xdrop_gap_final
    type:
      - 'null'
      - float
    doc: X-dropoff value (in bits) for final gapped alignment
    inputBinding:
      position: 101
      prefix: -xdrop_gap_final
  - id: xdrop_ungap
    type:
      - 'null'
      - float
    doc: X-dropoff value (in bits) for ungapped extensions
    inputBinding:
      position: 101
      prefix: -xdrop_ungap
outputs:
  - id: export_search_strategy
    type:
      - 'null'
      - File
    doc: File name to record the search strategy used
    outputBinding:
      glob: $(inputs.export_search_strategy)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reparation_blast:1.0.9--pl526_0
