cwlVersion: v1.2
class: CommandLineTool
baseCommand: megablast
label: blast-legacy_megablast
doc: "megablast 2.2.26: a tool for fast alignment of highly similar sequences\n\n
  Tool homepage: http://blast.ncbi.nlm.nih.gov"
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
  - id: believe_query_defline
    type:
      - 'null'
      - boolean
    doc: Believe the query defline
    default: false
    inputBinding:
      position: 101
      prefix: -J
  - id: database
    type:
      - 'null'
      - string
    doc: Database
    default: nr
    inputBinding:
      position: 101
      prefix: -d
  - id: discontiguous_template_length
    type:
      - 'null'
      - int
    doc: Length of a discontiguous word template (contiguous word if 0)
    default: 0
    inputBinding:
      position: 101
      prefix: -t
  - id: discontiguous_template_type
    type:
      - 'null'
      - int
    doc: Type of a discontiguous word template (0 - coding, 1 - optimal, 2 - two simultaneous)
    default: 0
    inputBinding:
      position: 101
      prefix: -N
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
    doc: Expectation value
    default: 10.0
    inputBinding:
      position: 101
      prefix: -e
  - id: filter_query
    type:
      - 'null'
      - string
    doc: Filter query sequence
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
  - id: full_ids
    type:
      - 'null'
      - boolean
    doc: Show full IDs in the output (default - only GIs or accessions)
    default: false
    inputBinding:
      position: 101
      prefix: -f
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
  - id: generate_words_every_base
    type:
      - 'null'
      - boolean
    doc: Make discontiguous megablast generate words for every base of the database
    default: true
    inputBinding:
      position: 101
      prefix: -g
  - id: gi_list
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
  - id: identity_percentage
    type:
      - 'null'
      - float
    doc: Identity percentage cut-off
    default: 0
    inputBinding:
      position: 101
      prefix: -p
  - id: lower_case_filtering
    type:
      - 'null'
      - boolean
    doc: Use lower case filtering of FASTA sequence
    default: false
    inputBinding:
      position: 101
      prefix: -U
  - id: match_reward
    type:
      - 'null'
      - int
    doc: Reward for a nucleotide match
    default: 1
    inputBinding:
      position: 101
      prefix: -r
  - id: max_hash_positions
    type:
      - 'null'
      - int
    doc: Maximal number of positions for a hash value (set to 0 to ignore)
    default: 0
    inputBinding:
      position: 101
      prefix: -P
  - id: max_hsps_per_sequence
    type:
      - 'null'
      - int
    doc: Maximal number of HSPs to save per database sequence (0 = unlimited)
    default: 0
    inputBinding:
      position: 101
      prefix: -H
  - id: max_query_length
    type:
      - 'null'
      - int
    doc: Maximal total length of queries for a single search
    default: 5000000
    inputBinding:
      position: 101
      prefix: -M
  - id: min_hit_score
    type:
      - 'null'
      - int
    doc: Minimal hit score to report (0 for default behavior)
    default: 0
    inputBinding:
      position: 101
      prefix: -s
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: Penalty for a nucleotide mismatch
    default: -3
    inputBinding:
      position: 101
      prefix: -q
  - id: multi_hit_window
    type:
      - 'null'
      - int
    doc: Multiple Hits window size; default is 0 (i.e. single-hit extensions) or 40
      for discontiguous template
    default: 0
    inputBinding:
      position: 101
      prefix: -A
  - id: non_greedy_extension
    type:
      - 'null'
      - boolean
    doc: Use non-greedy (dynamic programming) extension for affine gap scores
    default: false
    inputBinding:
      position: 101
      prefix: -n
  - id: num_alignments
    type:
      - 'null'
      - int
    doc: Number of database sequence to show alignments for (B)
    default: 250
    inputBinding:
      position: 101
      prefix: -b
  - id: num_descriptions
    type:
      - 'null'
      - int
    doc: Number of database sequences to show one-line descriptions for (V)
    default: 500
    inputBinding:
      position: 101
      prefix: -v
  - id: num_processors
    type:
      - 'null'
      - int
    doc: Number of processors to use
    default: 1
    inputBinding:
      position: 101
      prefix: -a
  - id: output_type
    type:
      - 'null'
      - int
    doc: 'Type of output: 0 - alignment endpoints and score, 1 - all ungapped segments
      endpoints, 2 - traditional BLAST output, 3 - tab-delimited one line format,
      4 - incremental text ASN.1, 5 - incremental binary ASN.1'
    default: 2
    inputBinding:
      position: 101
      prefix: -D
  - id: query_file
    type: File
    doc: Query File
    inputBinding:
      position: 101
      prefix: -i
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
    doc: 'Query strands to search against database: 3 is both, 1 is top, 2 is bottom'
    default: 3
    inputBinding:
      position: 101
      prefix: -S
  - id: report_log
    type:
      - 'null'
      - boolean
    doc: Report the log information at the end of output
    default: false
    inputBinding:
      position: 101
      prefix: -R
  - id: show_gi
    type:
      - 'null'
      - boolean
    doc: Show GI's in deflines
    default: false
    inputBinding:
      position: 101
      prefix: -I
  - id: word_size
    type:
      - 'null'
      - int
    doc: Word size (length of best perfect match)
    default: 28
    inputBinding:
      position: 101
      prefix: -W
  - id: x_dropoff_dynamic
    type:
      - 'null'
      - int
    doc: X dropoff value for dynamic programming gapped extension
    default: 50
    inputBinding:
      position: 101
      prefix: -Z
  - id: x_dropoff_gapped
    type:
      - 'null'
      - int
    doc: X dropoff value for gapped alignment (in bits)
    default: 20
    inputBinding:
      position: 101
      prefix: -X
  - id: x_dropoff_ungapped
    type:
      - 'null'
      - int
    doc: X dropoff value for ungapped extension
    default: 10
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
  - id: asn1_output
    type:
      - 'null'
      - File
    doc: ASN.1 SeqAlign file; must be used in conjunction with -D2 option
    outputBinding:
      glob: $(inputs.asn1_output)
  - id: masked_query_output
    type:
      - 'null'
      - File
    doc: Masked query output, must be used in conjunction with -D 2 option
    outputBinding:
      glob: $(inputs.masked_query_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blast-legacy:2.2.26--h9ee0642_3
