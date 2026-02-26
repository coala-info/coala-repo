cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastx36
label: fasta3_fastx36
doc: "FASTX compares a DNA sequence to a protein sequence data bank\n\nTool homepage:
  http://faculty.virginia.edu/wrpearson/fasta"
inputs:
  - id: query_file
    type: string
    doc: Query file (use stdin if '@')
    inputBinding:
      position: 1
  - id: library_file
    type: string
    doc: Library file
    inputBinding:
      position: 2
  - id: ktup
    type:
      - 'null'
      - int
    doc: K-tuple value
    inputBinding:
      position: 3
  - id: alignment_display_width
    type:
      - 'null'
      - int
    doc: width of alignment display
    inputBinding:
      position: 104
      prefix: -w
  - id: alignments_shown
    type:
      - 'null'
      - int
    doc: number of alignments shown (limited by -E by default)
    inputBinding:
      position: 104
      prefix: -d
  - id: annotation_characters
    type:
      - 'null'
      - string
    doc: annotation characters in query/library for aligments
    inputBinding:
      position: 104
      prefix: -V
  - id: database_size_for_e_value
    type:
      - 'null'
      - int
    doc: '[library entries] database size for E()-value'
    inputBinding:
      position: 104
      prefix: -Z
  - id: debug_output
    type:
      - 'null'
      - boolean
    doc: enable debugging output
    inputBinding:
      position: 104
      prefix: -D
  - id: dna_rna_match_mismatch
    type:
      - 'null'
      - string
    doc: '[+0/0] +match/-mismatch for DNA/RNA'
    inputBinding:
      position: 104
      prefix: -r
  - id: dna_rna_query
    type:
      - 'null'
      - boolean
    doc: DNA/RNA query
    inputBinding:
      position: 104
      prefix: -n
  - id: e_value_threshold
    type:
      - 'null'
      - float
    doc: E()-value,E()-repeat threshold
    inputBinding:
      position: 104
      prefix: -E
  - id: expand_script
    type:
      - 'null'
      - string
    doc: expand_script to extend hits
    inputBinding:
      position: 104
      prefix: -e
  - id: expected_fraction_band_optimization
    type:
      - 'null'
      - float
    doc: expected fraction for band-optimization, joining
    inputBinding:
      position: 104
      prefix: -c
  - id: extended_options
    type:
      - 'null'
      - boolean
    doc: Extended options
    inputBinding:
      position: 104
      prefix: -X
  - id: fastlibs_abbreviation_file
    type:
      - 'null'
      - File
    doc: FASTLIBS abbreviation file
    inputBinding:
      position: 104
      prefix: -l
  - id: filter_library_sequence_length
    type:
      - 'null'
      - int
    doc: filter on library sequence length
    inputBinding:
      position: 104
      prefix: -M
  - id: filter_lowercase_seg_residues
    type:
      - 'null'
      - boolean
    doc: filter lowercase (seg) residues
    inputBinding:
      position: 104
      prefix: -S
  - id: forward_strand_only
    type:
      - 'null'
      - boolean
    doc: compare forward strand only
    inputBinding:
      position: 104
      prefix: '-3'
  - id: frame_shift_penalty
    type:
      - 'null'
      - int
    doc: frame-shift penalty
    inputBinding:
      position: 104
      prefix: -j
  - id: gap_extension_penalty
    type:
      - 'null'
      - int
    doc: gap-extension penalty
    inputBinding:
      position: 104
      prefix: -g
  - id: gap_open_penalty
    type:
      - 'null'
      - int
    doc: gap-open penalty
    inputBinding:
      position: 104
      prefix: -f
  - id: high_scores_limit
    type:
      - 'null'
      - int
    doc: high scores reported (limited by -E by default); forces <int> results
    inputBinding:
      position: 104
      prefix: -b
  - id: interactive_mode
    type:
      - 'null'
      - boolean
    doc: interactive mode
    inputBinding:
      position: 104
      prefix: -I
  - id: long_library_descriptions
    type:
      - 'null'
      - boolean
    doc: long library descriptions
    inputBinding:
      position: 104
      prefix: -L
  - id: max_library_length_before_overlapping
    type:
      - 'null'
      - int
    doc: max library length before overlapping
    inputBinding:
      position: 104
      prefix: -N
  - id: max_threads
    type:
      - 'null'
      - int
    doc: max threads/workers
    inputBinding:
      position: 104
      prefix: -T
  - id: min_e_value_displayed
    type:
      - 'null'
      - float
    doc: min E()-value displayed
    inputBinding:
      position: 104
      prefix: -F
  - id: offset_coordinates
    type:
      - 'null'
      - string
    doc: offset coordinates of query/subject
    inputBinding:
      position: 104
      prefix: -o
  - id: output_alignment_format
    type:
      - 'null'
      - string
    doc: Output/alignment format
    inputBinding:
      position: 104
      prefix: -m
  - id: protein_query
    type:
      - 'null'
      - boolean
    doc: protein query
    inputBinding:
      position: 104
      prefix: -p
  - id: query_sbjct_name_length
    type:
      - 'null'
      - int
    doc: length of the query/sbjct name in alignments
    inputBinding:
      position: 104
      prefix: -C
  - id: quiet_no_prompt
    type:
      - 'null'
      - boolean
    doc: quiet [default] -- do not prompt
    inputBinding:
      position: 104
      prefix: -q
  - id: quiet_no_prompt_2
    type:
      - 'null'
      - boolean
    doc: quiet [default] -- do not prompt
    inputBinding:
      position: 104
      prefix: -Q
  - id: raw_score_file
    type:
      - 'null'
      - File
    doc: raw score file
    inputBinding:
      position: 104
      prefix: -R
  - id: rna_query
    type:
      - 'null'
      - boolean
    doc: RNA query
    inputBinding:
      position: 104
      prefix: -U
  - id: scoring_matrix
    type:
      - 'null'
      - string
    doc: 'Scoring matrix: (protein)'
    inputBinding:
      position: 104
      prefix: -s
  - id: search_reverse_complement
    type:
      - 'null'
      - boolean
    doc: search with reverse-complement
    inputBinding:
      position: 104
      prefix: -i
  - id: show_histogram
    type:
      - 'null'
      - boolean
    doc: show histogram
    inputBinding:
      position: 104
      prefix: -H
  - id: shuffle_window_size
    type:
      - 'null'
      - int
    doc: shuffle window size
    inputBinding:
      position: 104
      prefix: -v
  - id: shuffles
    type:
      - 'null'
      - int
    doc: number of shuffles
    inputBinding:
      position: 104
      prefix: -k
  - id: statistics_estimation_method
    type:
      - 'null'
      - int
    doc: Statistics estimation method
    inputBinding:
      position: 104
      prefix: -z
  - id: translation_genetic_code
    type:
      - 'null'
      - int
    doc: translation genetic code
    inputBinding:
      position: 104
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: write results to file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasta3:36.3.8--0
