cwlVersion: v1.2
class: CommandLineTool
baseCommand: blastp
label: blast_blastp
doc: Protein-Protein BLAST 2.17.0+
inputs:
  - id: query
    type: File
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
  - id: task
    type:
      - 'null'
      - string
    doc: Task to execute (blastp, blastp-fast, blastp-short)
    inputBinding:
      position: 101
      prefix: -task
  - id: db_dir
    type:
      - 'null'
      - Directory
    doc: >
      Directory containing BLAST database files for one prefix
      (e.g. subject_database.phr, subject_database.pin, subject_database.psq).
  - id: db_prefix
    type: string?
    doc: >
      Database basename inside db_dir (no extension), e.g. subject_database.
      blastp -db is set to db_dir/path + '/' + db_prefix.
    inputBinding:
      position: 101
      prefix: -db
      valueFrom: $(inputs.db_dir.path + '/' + self)
  - id: out
    type: string
    doc: Output file name
    inputBinding:
      position: 101
      prefix: -out
  - id: evalue
    type:
      - 'null'
      - float
    doc: Expectation value (E) threshold for saving hits
    inputBinding:
      position: 101
      prefix: -evalue
  - id: word_size
    type:
      - 'null'
      - int
    doc: Word size for wordfinder algorithm
    inputBinding:
      position: 101
      prefix: -word_size
  - id: gapopen
    type:
      - 'null'
      - int
    doc: Cost to open a gap
    inputBinding:
      position: 101
      prefix: -gapopen
  - id: gapextend
    type:
      - 'null'
      - int
    doc: Cost to extend a gap
    inputBinding:
      position: 101
      prefix: -gapextend
  - id: matrix
    type:
      - 'null'
      - string
    doc: Scoring matrix name (normally BLOSUM62)
    inputBinding:
      position: 101
      prefix: -matrix
  - id: threshold
    type:
      - 'null'
      - float
    doc: Minimum word score such that the word is added to the BLAST lookup 
      table
    inputBinding:
      position: 101
      prefix: -threshold
  - id: comp_based_stats
    type:
      - 'null'
      - string
    doc: Use composition-based statistics
    inputBinding:
      position: 101
      prefix: -comp_based_stats
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
  - id: outfmt
    type:
      - 'null'
      - string
    doc: alignment view options
    inputBinding:
      position: 101
      prefix: -outfmt
  - id: show_gis
    type:
      - 'null'
      - boolean
    doc: Show NCBI GIs in deflines?
    inputBinding:
      position: 101
      prefix: -show_gis
  - id: num_descriptions
    type:
      - 'null'
      - int
    doc: Number of database sequences to show one-line descriptions for
    inputBinding:
      position: 101
      prefix: -num_descriptions
  - id: num_alignments
    type:
      - 'null'
      - int
    doc: Number of database sequences to show alignments for
    inputBinding:
      position: 101
      prefix: -num_alignments
  - id: line_length
    type:
      - 'null'
      - int
    doc: Line length for formatting alignments
    inputBinding:
      position: 101
      prefix: -line_length
  - id: html
    type:
      - 'null'
      - boolean
    doc: Produce HTML output?
    inputBinding:
      position: 101
      prefix: -html
  - id: sorthits
    type:
      - 'null'
      - int
    doc: Sorting option for hits
    inputBinding:
      position: 101
      prefix: -sorthits
  - id: sorthsps
    type:
      - 'null'
      - int
    doc: Sorting option for hps
    inputBinding:
      position: 101
      prefix: -sorthsps
  - id: seg
    type:
      - 'null'
      - string
    doc: Filter query sequence with SEG
    inputBinding:
      position: 101
      prefix: -seg
  - id: soft_masking
    type:
      - 'null'
      - boolean
    doc: Apply filtering locations as soft masks
    inputBinding:
      position: 101
      prefix: -soft_masking
  - id: lcase_masking
    type:
      - 'null'
      - boolean
    doc: Use lower case filtering in query and subject sequence(s)?
    inputBinding:
      position: 101
      prefix: -lcase_masking
  - id: gilist
    type:
      - 'null'
      - string
    doc: Restrict search of database to list of GIs
    inputBinding:
      position: 101
      prefix: -gilist
  - id: seqidlist
    type:
      - 'null'
      - string
    doc: Restrict search of database to list of SeqIDs
    inputBinding:
      position: 101
      prefix: -seqidlist
  - id: negative_gilist
    type:
      - 'null'
      - string
    doc: Restrict search of database to everything except the specified GIs
    inputBinding:
      position: 101
      prefix: -negative_gilist
  - id: negative_seqidlist
    type:
      - 'null'
      - string
    doc: Restrict search of database to everything except the specified SeqIDs
    inputBinding:
      position: 101
      prefix: -negative_seqidlist
  - id: taxids
    type:
      - 'null'
      - string
    doc: Restrict search of database to include only the specified taxonomy IDs
    inputBinding:
      position: 101
      prefix: -taxids
  - id: negative_taxids
    type:
      - 'null'
      - string
    doc: Restrict search of database to everything except the specified taxonomy
      IDs
    inputBinding:
      position: 101
      prefix: -negative_taxids
  - id: taxidlist
    type:
      - 'null'
      - string
    doc: Restrict search of database to include only the specified taxonomy IDs
    inputBinding:
      position: 101
      prefix: -taxidlist
  - id: negative_taxidlist
    type:
      - 'null'
      - string
    doc: Restrict search of database to everything except the specified taxonomy
      IDs
    inputBinding:
      position: 101
      prefix: -negative_taxidlist
  - id: no_taxid_expansion
    type:
      - 'null'
      - boolean
    doc: Do not expand the taxonomy IDs provided to their descendant taxonomy 
      IDs
    inputBinding:
      position: 101
      prefix: -no_taxid_expansion
  - id: ipglist
    type:
      - 'null'
      - string
    doc: Restrict search of database to list of IPGs
    inputBinding:
      position: 101
      prefix: -ipglist
  - id: negative_ipglist
    type:
      - 'null'
      - string
    doc: Restrict search of database to everything except the specified IPGs
    inputBinding:
      position: 101
      prefix: -negative_ipglist
  - id: entrez_query
    type:
      - 'null'
      - string
    doc: Restrict search with the given Entrez query
    inputBinding:
      position: 101
      prefix: -entrez_query
  - id: db_soft_mask
    type:
      - 'null'
      - string
    doc: Filtering algorithm ID to apply to the BLAST database as soft masking
    inputBinding:
      position: 101
      prefix: -db_soft_mask
  - id: db_hard_mask
    type:
      - 'null'
      - string
    doc: Filtering algorithm ID to apply to the BLAST database as hard masking
    inputBinding:
      position: 101
      prefix: -db_hard_mask
  - id: qcov_hsp_perc
    type:
      - 'null'
      - float
    doc: Percent query coverage per hsp
    inputBinding:
      position: 101
      prefix: -qcov_hsp_perc
  - id: max_hsps
    type:
      - 'null'
      - int
    doc: Set maximum number of HSPs per subject sequence to save for each query
    inputBinding:
      position: 101
      prefix: -max_hsps
  - id: culling_limit
    type:
      - 'null'
      - int
    doc: If the query range of a hit is enveloped by that of at least this many 
      higher-scoring hits, delete the hit
    inputBinding:
      position: 101
      prefix: -culling_limit
  - id: best_hit_overhang
    type:
      - 'null'
      - float
    doc: Best Hit algorithm overhang value
    inputBinding:
      position: 101
      prefix: -best_hit_overhang
  - id: best_hit_score_edge
    type:
      - 'null'
      - float
    doc: Best Hit algorithm score edge value
    inputBinding:
      position: 101
      prefix: -best_hit_score_edge
  - id: subject_besthit
    type:
      - 'null'
      - boolean
    doc: Return only the best HSP for each non overlapping query region
    inputBinding:
      position: 101
      prefix: -subject_besthit
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: Maximum number of aligned sequences to keep
    inputBinding:
      position: 101
      prefix: -max_target_seqs
  - id: dbsize
    type:
      - 'null'
      - int
    doc: Effective length of the database
    inputBinding:
      position: 101
      prefix: -dbsize
  - id: searchsp
    type:
      - 'null'
      - int
    doc: Effective length of the search space
    inputBinding:
      position: 101
      prefix: -searchsp
  - id: import_search_strategy
    type:
      - 'null'
      - File
    doc: Search strategy to use
    inputBinding:
      position: 101
      prefix: -import_search_strategy
  - id: export_search_strategy
    type: string?
    doc: File name to record the search strategy used
    inputBinding:
      position: 101
      prefix: -export_search_strategy
  - id: xdrop_ungap
    type:
      - 'null'
      - float
    doc: X-dropoff value (in bits) for ungapped extensions
    inputBinding:
      position: 101
      prefix: -xdrop_ungap
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
  - id: window_size
    type:
      - 'null'
      - int
    doc: Multiple hits window size, use 0 to specify 1-hit algorithm
    inputBinding:
      position: 101
      prefix: -window_size
  - id: ungapped
    type:
      - 'null'
      - boolean
    doc: Perform ungapped alignment only?
    inputBinding:
      position: 101
      prefix: -ungapped
  - id: parse_deflines
    type:
      - 'null'
      - boolean
    doc: Should the query and subject defline(s) be parsed?
    inputBinding:
      position: 101
      prefix: -parse_deflines
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads (CPUs) to use in the BLAST search
    inputBinding:
      position: 101
      prefix: -num_threads
  - id: mt_mode
    type:
      - 'null'
      - int
    doc: Multi-thread mode to use in BLAST search
    inputBinding:
      position: 101
      prefix: -mt_mode
  - id: remote
    type:
      - 'null'
      - boolean
    doc: Execute search remotely?
    inputBinding:
      position: 101
      prefix: -remote
  - id: use_sw_tback
    type:
      - 'null'
      - boolean
    doc: Compute locally optimal Smith-Waterman alignments?
    inputBinding:
      position: 101
      prefix: -use_sw_tback
outputs:
  - id: output_out
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.out)
  - id: output_export_search_strategy
    type:
      - 'null'
      - File
    doc: File name to record the search strategy used
    outputBinding:
      glob: $(inputs.export_search_strategy)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blast:2.17.0--h66d330f_0
s:url: https://blast.ncbi.nlm.nih.gov/doc/blast-help/
$namespaces:
  s: https://schema.org/
