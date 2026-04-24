cwlVersion: v1.2
class: CommandLineTool
baseCommand: blastx
label: trinotate_blastx
doc: "Translated Query-Protein Subject BLAST 2.14.1+\n\nTool homepage: https://trinotate.github.io/"
inputs:
  - id: best_hit_overhang
    type:
      - 'null'
      - float
    doc: 'Best Hit algorithm overhang value (recommended value: 0.1)'
    inputBinding:
      position: 101
      prefix: --best_hit_overhang
  - id: best_hit_score_edge
    type:
      - 'null'
      - float
    doc: 'Best Hit algorithm score edge value (recommended value: 0.1)'
    inputBinding:
      position: 101
      prefix: --best_hit_score_edge
  - id: comp_based_stats
    type:
      - 'null'
      - string
    doc: Use composition-based statistics
    inputBinding:
      position: 101
      prefix: --comp_based_stats
  - id: culling_limit
    type:
      - 'null'
      - int
    doc: If the query range of a hit is enveloped by that of at least this many 
      higher-scoring hits, delete the hit
    inputBinding:
      position: 101
      prefix: --culling_limit
  - id: db
    type:
      - 'null'
      - string
    doc: BLAST database name
    inputBinding:
      position: 101
      prefix: --db
  - id: db_hard_mask
    type:
      - 'null'
      - string
    doc: Filtering algorithm ID to apply to the BLAST database as hard masking
    inputBinding:
      position: 101
      prefix: --db_hard_mask
  - id: db_soft_mask
    type:
      - 'null'
      - string
    doc: Filtering algorithm ID to apply to the BLAST database as soft masking
    inputBinding:
      position: 101
      prefix: --db_soft_mask
  - id: dbsize
    type:
      - 'null'
      - int
    doc: Effective length of the database
    inputBinding:
      position: 101
      prefix: --dbsize
  - id: entrez_query
    type:
      - 'null'
      - string
    doc: Restrict search with the given Entrez query
    inputBinding:
      position: 101
      prefix: --entrez_query
  - id: evalue
    type:
      - 'null'
      - float
    doc: Expectation value (E) threshold for saving hits.
    inputBinding:
      position: 101
      prefix: --evalue
  - id: export_search_strategy
    type:
      - 'null'
      - File
    doc: File name to record the search strategy used
    inputBinding:
      position: 101
      prefix: --export_search_strategy
  - id: gapextend
    type:
      - 'null'
      - int
    doc: Cost to extend a gap
    inputBinding:
      position: 101
      prefix: --gapextend
  - id: gapopen
    type:
      - 'null'
      - int
    doc: Cost to open a gap
    inputBinding:
      position: 101
      prefix: --gapopen
  - id: gilist
    type:
      - 'null'
      - File
    doc: Restrict search of database to list of GIs
    inputBinding:
      position: 101
      prefix: --gilist
  - id: html
    type:
      - 'null'
      - boolean
    doc: Produce HTML output?
    inputBinding:
      position: 101
      prefix: --html
  - id: import_search_strategy
    type:
      - 'null'
      - File
    doc: Search strategy to use
    inputBinding:
      position: 101
      prefix: --import_search_strategy
  - id: ipglist
    type:
      - 'null'
      - File
    doc: Restrict search of database to list of IPGs
    inputBinding:
      position: 101
      prefix: --ipglist
  - id: lcase_masking
    type:
      - 'null'
      - boolean
    doc: Use lower case filtering in query and subject sequence(s)?
    inputBinding:
      position: 101
      prefix: --lcase_masking
  - id: line_length
    type:
      - 'null'
      - int
    doc: Line length for formatting alignments
    inputBinding:
      position: 101
      prefix: --line_length
  - id: matrix
    type:
      - 'null'
      - string
    doc: Scoring matrix name (normally BLOSUM62)
    inputBinding:
      position: 101
      prefix: --matrix
  - id: max_hsps
    type:
      - 'null'
      - int
    doc: Set maximum number of HSPs per subject sequence to save for each query
    inputBinding:
      position: 101
      prefix: --max_hsps
  - id: max_intron_length
    type:
      - 'null'
      - int
    doc: Length of the largest intron allowed in a translated nucleotide 
      sequence when linking multiple distinct alignments
    inputBinding:
      position: 101
      prefix: --max_intron_length
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: Maximum number of aligned sequences to keep
    inputBinding:
      position: 101
      prefix: --max_target_seqs
  - id: mt_mode
    type:
      - 'null'
      - int
    doc: Multi-thread mode to use in BLAST search
    inputBinding:
      position: 101
      prefix: --mt_mode
  - id: negative_gilist
    type:
      - 'null'
      - File
    doc: Restrict search of database to everything except the specified GIs
    inputBinding:
      position: 101
      prefix: --negative_gilist
  - id: negative_ipglist
    type:
      - 'null'
      - File
    doc: Restrict search of database to everything except the specified IPGs
    inputBinding:
      position: 101
      prefix: --negative_ipglist
  - id: negative_seqidlist
    type:
      - 'null'
      - File
    doc: Restrict search of database to everything except the specified SeqIDs
    inputBinding:
      position: 101
      prefix: --negative_seqidlist
  - id: negative_taxidlist
    type:
      - 'null'
      - File
    doc: Restrict search of database to everything except the specified taxonomy
      IDs
    inputBinding:
      position: 101
      prefix: --negative_taxidlist
  - id: negative_taxids
    type:
      - 'null'
      - string
    doc: Restrict search of database to everything except the specified taxonomy
      IDs (multiple IDs delimited by ',')
    inputBinding:
      position: 101
      prefix: --negative_taxids
  - id: num_alignments
    type:
      - 'null'
      - int
    doc: Number of database sequences to show alignments for
    inputBinding:
      position: 101
      prefix: --num_alignments
  - id: num_descriptions
    type:
      - 'null'
      - int
    doc: Number of database sequences to show one-line descriptions for
    inputBinding:
      position: 101
      prefix: --num_descriptions
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads (CPUs) to use in the BLAST search
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: outfmt
    type:
      - 'null'
      - string
    doc: alignment view options
    inputBinding:
      position: 101
      prefix: --outfmt
  - id: parse_deflines
    type:
      - 'null'
      - boolean
    doc: Should the query and subject defline(s) be parsed?
    inputBinding:
      position: 101
      prefix: --parse_deflines
  - id: qcov_hsp_perc
    type:
      - 'null'
      - float
    doc: Percent query coverage per hsp
    inputBinding:
      position: 101
      prefix: --qcov_hsp_perc
  - id: query
    type:
      - 'null'
      - File
    doc: Input file name
    inputBinding:
      position: 101
      prefix: --query
  - id: query_gencode
    type:
      - 'null'
      - int
    doc: Genetic code to use to translate query (see 
      https://www.ncbi.nlm.nih.gov/Taxonomy/taxonomyhome.html/index.cgi?chapter=cgencodes
      for details)
    inputBinding:
      position: 101
      prefix: --query_gencode
  - id: query_loc
    type:
      - 'null'
      - string
    doc: 'Location on the query sequence in 1-based offsets (Format: start-stop)'
    inputBinding:
      position: 101
      prefix: --query_loc
  - id: remote
    type:
      - 'null'
      - boolean
    doc: Execute search remotely?
    inputBinding:
      position: 101
      prefix: --remote
  - id: searchsp
    type:
      - 'null'
      - int
    doc: Effective length of the search space
    inputBinding:
      position: 101
      prefix: --searchsp
  - id: seg
    type:
      - 'null'
      - string
    doc: "Filter query sequence with SEG (Format: 'yes', 'window locut hicut', or
      'no' to disable)"
    inputBinding:
      position: 101
      prefix: --seg
  - id: seqidlist
    type:
      - 'null'
      - File
    doc: Restrict search of database to list of SeqIDs
    inputBinding:
      position: 101
      prefix: --seqidlist
  - id: show_gis
    type:
      - 'null'
      - boolean
    doc: Show NCBI GIs in deflines?
    inputBinding:
      position: 101
      prefix: --show_gis
  - id: soft_masking
    type:
      - 'null'
      - boolean
    doc: Apply filtering locations as soft masks
    inputBinding:
      position: 101
      prefix: --soft_masking
  - id: sorthits
    type:
      - 'null'
      - int
    doc: Sorting option for hits
    inputBinding:
      position: 101
      prefix: --sorthits
  - id: sorthsps
    type:
      - 'null'
      - int
    doc: Sorting option for hps
    inputBinding:
      position: 101
      prefix: --sorthsps
  - id: strand
    type:
      - 'null'
      - string
    doc: Query strand(s) to search against database/subject
    inputBinding:
      position: 101
      prefix: --strand
  - id: subject
    type:
      - 'null'
      - File
    doc: Subject sequence(s) to search
    inputBinding:
      position: 101
      prefix: --subject
  - id: subject_besthit
    type:
      - 'null'
      - boolean
    doc: Turn on best hit per subject sequence
    inputBinding:
      position: 101
      prefix: --subject_besthit
  - id: subject_loc
    type:
      - 'null'
      - string
    doc: 'Location on the subject sequence in 1-based offsets (Format: start-stop)'
    inputBinding:
      position: 101
      prefix: --subject_loc
  - id: sum_stats
    type:
      - 'null'
      - boolean
    doc: Use sum statistics
    inputBinding:
      position: 101
      prefix: --sum_stats
  - id: task
    type:
      - 'null'
      - string
    doc: Task to execute
    inputBinding:
      position: 101
      prefix: --task
  - id: taxidlist
    type:
      - 'null'
      - File
    doc: Restrict search of database to include only the specified taxonomy IDs
    inputBinding:
      position: 101
      prefix: --taxidlist
  - id: taxids
    type:
      - 'null'
      - string
    doc: Restrict search of database to include only the specified taxonomy IDs 
      (multiple IDs delimited by ',')
    inputBinding:
      position: 101
      prefix: --taxids
  - id: threshold
    type:
      - 'null'
      - float
    doc: Minimum word score such that the word is added to the BLAST lookup 
      table
    inputBinding:
      position: 101
      prefix: --threshold
  - id: ungapped
    type:
      - 'null'
      - boolean
    doc: Perform ungapped alignment only?
    inputBinding:
      position: 101
      prefix: --ungapped
  - id: use_sw_tback
    type:
      - 'null'
      - boolean
    doc: Compute locally optimal Smith-Waterman alignments?
    inputBinding:
      position: 101
      prefix: --use_sw_tback
  - id: window_size
    type:
      - 'null'
      - int
    doc: Multiple hits window size, use 0 to specify 1-hit algorithm
    inputBinding:
      position: 101
      prefix: --window_size
  - id: word_size
    type:
      - 'null'
      - int
    doc: Word size for wordfinder algorithm
    inputBinding:
      position: 101
      prefix: --word_size
  - id: xdrop_gap
    type:
      - 'null'
      - float
    doc: X-dropoff value (in bits) for preliminary gapped extensions
    inputBinding:
      position: 101
      prefix: --xdrop_gap
  - id: xdrop_gap_final
    type:
      - 'null'
      - float
    doc: X-dropoff value (in bits) for final gapped alignment
    inputBinding:
      position: 101
      prefix: --xdrop_gap_final
  - id: xdrop_ungap
    type:
      - 'null'
      - float
    doc: X-dropoff value (in bits) for ungapped extensions
    inputBinding:
      position: 101
      prefix: --xdrop_ungap
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trinotate:4.0.2--pl5321hdfd78af_0
