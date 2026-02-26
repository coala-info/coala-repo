cwlVersion: v1.2
class: CommandLineTool
baseCommand: tfastx36
label: fasta3_tfastx36
doc: "TFASTX compares a protein to a translated DNA data bank\n\nTool homepage: http://faculty.virginia.edu/wrpearson/fasta"
inputs:
  - id: query_file
    type: string
    doc: Query file (use "@" for stdin, or query_file:begin-end for subset 
      range)
    inputBinding:
      position: 1
  - id: library_file
    type: string
    doc: 'Library file (formats: 0:FASTA; 1:GenBankFF; 3:EMBL_FF; 7:FASTQ; 10:subset;
      12:NCBI blastdbcmd; alternate: "library_file 7" for 7:FASTQ)'
    inputBinding:
      position: 2
  - id: ktup
    type:
      - 'null'
      - int
    doc: K-tuple size
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
  - id: annotation_chars
    type:
      - 'null'
      - string
    doc: annotation characters in query/library for aligments
    inputBinding:
      position: 104
      prefix: -V
  - id: compare_forward_strand_only
    type:
      - 'null'
      - boolean
    doc: compare forward strand only
    inputBinding:
      position: 104
      prefix: '-3'
  - id: database_size_e_value
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
  - id: filter_library_seq_length
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
  - id: high_scores_reported
    type:
      - 'null'
      - int
    doc: high scores reported (limited by -E by default); =<int> forces <int> 
      results
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
  - id: match_mismatch_dna_rna
    type:
      - 'null'
      - string
    doc: '[+0/0]  +match/-mismatch for DNA/RNA'
    inputBinding:
      position: 104
      prefix: -r
  - id: max_library_length_before_overlapping
    type:
      - 'null'
      - int
    doc: max library length before overlapping
    inputBinding:
      position: 104
      prefix: -N
  - id: max_threads_workers
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
  - id: num_alignments_shown
    type:
      - 'null'
      - int
    doc: number of alignments shown (limited by -E by default)
    inputBinding:
      position: 104
      prefix: -d
  - id: num_shuffles
    type:
      - 'null'
      - int
    doc: number of shuffles
    inputBinding:
      position: 104
      prefix: -k
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
    doc: Output/alignment format; 0 - standard ":. " alignment; 1 - " xX"; 2 - 
      ".MS.."; 3 - separate >fasta entries; 4 - "---" alignment map; 5 - 0+4; 6 
      - <html>; 8 - BLAST tabular; 8C commented BLAST tabular; B - BLAST 
      Query/Sbjct alignments; BB - complete BLAST output; 9 - FASTA tabular; 9c 
      - FASTA tabular encoded; 9C FASTA tabular CIGAR encoded; 10 - parseable 
      key:value; 11 - lav for LALIGN; A - aligned residue score; F - 'F0,6,9c 
      out_file' - alternate output formats to files
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
    doc: 'Scoring matrix: (protein) BL50, BP62 (sets -f -11 -g -1); P250, OPT5, VT200,
      VT160, P120, VT120, BL80, VT80, MD40, VT40, MD20, VT20, MD10, VT10; scoring
      matrix file name; -s ?BL50 adjusts matrix for short queries'
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
  - id: statistics_estimation_method
    type:
      - 'null'
      - int
    doc: 'Statistics estimation method: 1 - regression; -1 - no stats.; 0 - no scaling;
      2 - Maximum Likelihood Est.; 3 - Altschul/Gish; 4 - iter. regress.; 5 - regress
      w/variance; 6 - MLE with comp. adj.; 11 - 16 - estimates from shuffled library
      sequences; 21 - 26 - E2()-stats from shuffled high-scoring sequences'
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
