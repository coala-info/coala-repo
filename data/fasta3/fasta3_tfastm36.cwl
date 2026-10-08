cwlVersion: v1.2
class: CommandLineTool
baseCommand: tfastm36
label: fasta3_tfastm36
doc: "TFASTM compares ordered peptides to a translated DNA databank\n\nTool homepage: http://faculty.virginia.edu/wrpearson/fasta"
inputs:
  - id: query_file
    type: File
    doc: Query file ("@" reads stdin, query_file:begin-end sets a subset range; a range cannot be used with a staged File).
    inputBinding:
      position: 201
  - id: library_file
    type: File
    doc: 'Library file. Formats: 0:FASTA; 1:GenBankFF; 3:EMBL_FF; 7:FASTQ; 10:subset; 12:NCBI blastdbcmd.'
    inputBinding:
      position: 202
  - id: ktup
    type: ['null', int]
    doc: KTUP value for search.
    inputBinding:
      position: 203
  - id: compare_forward_strand_only
    type: ['null', boolean]
    doc: compare forward strand only
    inputBinding:
      position: 101
      prefix: '-3'
  - id: high_scores_reported
    type: ['null', string]
    doc: high scores reported (limited by -E by default); =<int> forces <int> results;
    inputBinding:
      position: 101
      prefix: -b
  - id: query_sbjct_name_length
    type: ['null', int]
    doc: length of the query/sbjct name in alignments
    inputBinding:
      position: 101
      prefix: -C
  - id: num_alignments_shown
    type: ['null', int]
    doc: number of alignments shown (limited by -E by default)
    inputBinding:
      position: 101
      prefix: -d
  - id: enable_debugging
    type: ['null', boolean]
    doc: enable debugging output
    inputBinding:
      position: 101
      prefix: -D
  - id: expand_script_hits
    type: ['null', string]
    doc: expand_script to extend hits
    inputBinding:
      position: 101
      prefix: -e
  - id: e_value_threshold
    type: ['null', string]
    doc: E()-value,E()-repeat threshold
    inputBinding:
      position: 101
      prefix: -E
  - id: gap_open_penalty
    type: ['null', int]
    doc: gap-open penalty
    inputBinding:
      position: 101
      prefix: -f
  - id: min_e_value_displayed
    type: ['null', float]
    doc: min E()-value displayed
    inputBinding:
      position: 101
      prefix: -F
  - id: gap_extension_penalty
    type: ['null', int]
    doc: gap-extension penalty
    inputBinding:
      position: 101
      prefix: -g
  - id: show_histogram
    type: ['null', boolean]
    doc: show histogram
    inputBinding:
      position: 101
      prefix: -H
  - id: search_reverse_complement
    type: ['null', boolean]
    doc: search with reverse-complement
    inputBinding:
      position: 101
      prefix: -i
  - id: interactive_mode
    type: ['null', boolean]
    doc: interactive mode
    inputBinding:
      position: 101
      prefix: -I
  - id: num_shuffles
    type: ['null', int]
    doc: number of shuffles
    inputBinding:
      position: 101
      prefix: -k
  - id: fastlibs_abbreviation_file
    type: ['null', File]
    doc: FASTLIBS abbreviation file
    inputBinding:
      position: 101
      prefix: -l
  - id: long_library_descriptions
    type: ['null', boolean]
    doc: long library descriptions
    inputBinding:
      position: 101
      prefix: -L
  - id: output_alignment_format
    type: ['null', string]
    doc: Output/alignment format; 0 - standard ":. " alignment; 1 - " xX"; 2 - ".MS.."; 3 - separate >fasta entries; 4 - "---" alignment map; 5 - 0+4; 6 - <html>; 8 - BLAST tabular; 8C commented BLAST tabular; B - BLAST Query/Sbjct alignments; BB - complete BLAST output; 9 - FASTA tabular; 9c - FASTA tabular encoded; 9C FASTA tabular CIGAR encoded; A - aligned residue score F - 'F0,6,9c out_file' - alternate output formats to files;
    inputBinding:
      position: 101
      prefix: -m
  - id: filter_library_length
    type: ['null', string]
    doc: filter on library sequence length
    inputBinding:
      position: 101
      prefix: -M
  - id: dna_rna_query
    type: ['null', boolean]
    doc: DNA/RNA query
    inputBinding:
      position: 101
      prefix: -n
  - id: max_library_length_overlap
    type: ['null', int]
    doc: max library length before overlapping
    inputBinding:
      position: 101
      prefix: -N
  - id: offset_coordinates
    type: ['null', string]
    doc: offset coordinates of query/subject
    inputBinding:
      position: 101
      prefix: -o
  - id: output_file_path
    type: ['null', string]
    doc: Write results to this file.
    inputBinding:
      position: 101
      prefix: -O
  - id: protein_query
    type: ['null', boolean]
    doc: protein query
    inputBinding:
      position: 101
      prefix: -p
  - id: quiet_no_prompt
    type: ['null', boolean]
    doc: quiet [default] -- do not prompt
    inputBinding:
      position: 101
      prefix: -q
  - id: quiet_no_prompt_2
    type: ['null', boolean]
    doc: quiet [default] -- do not prompt
    inputBinding:
      position: 101
      prefix: -Q
  - id: dna_rna_match_mismatch
    type: ['null', string]
    doc: '[+0/0]  +match/-mismatch for DNA/RNA'
    inputBinding:
      position: 101
      prefix: -r
  - id: raw_score_file
    type: ['null', File]
    doc: raw score file
    inputBinding:
      position: 101
      prefix: -R
  - id: scoring_matrix
    type: ['null', string]
    doc: 'Scoring matrix: (protein) BL50, BP62 (sets -f -11 -g -1); P250, OPT5, VT200, VT160, P120, VT120, BL80, VT80, MD40, VT40, MD20, VT20, MD10, VT10; scoring matrix file name; -s ?BL50 adjusts matrix for short queries;'
    inputBinding:
      position: 101
      prefix: -s
  - id: translation_table
    type: ['null', int]
    doc: translation genetic code
    inputBinding:
      position: 101
      prefix: -t
  - id: max_threads
    type: ['null', int]
    doc: max threads/workers
    inputBinding:
      position: 101
      prefix: -T
  - id: rna_query
    type: ['null', boolean]
    doc: RNA query
    inputBinding:
      position: 101
      prefix: -U
  - id: shuffle_window_size
    type: ['null', int]
    doc: shuffle window size
    inputBinding:
      position: 101
      prefix: -v
  - id: annotation_chars_query_library
    type: ['null', string]
    doc: annotation characters in query/library for aligments
    inputBinding:
      position: 101
      prefix: -V
  - id: alignment_display_width
    type: ['null', int]
    doc: width of alignment display
    inputBinding:
      position: 101
      prefix: -w
  - id: extended_options
    type: ['null', string]
    doc: Extended options
    inputBinding:
      position: 101
      prefix: -X
  - id: stats_estimation_method
    type: ['null', int]
    doc: 'Statistics estimation method: 1 - regression; -1 - no stats.; 0 - no scaling; 2 - Maximum Likelihood Est.; 3 - Altschul/Gish; 4 - iter. regress.; 5 - regress w/variance; 6 - MLE with comp. adj.;'
    inputBinding:
      position: 101
      prefix: -z
  - id: database_size_e_value
    type: ['null', int]
    doc: '[library entries] database size for E()-value'
    inputBinding:
      position: 101
      prefix: -Z
outputs:
  - id: search_results
    type: stdout
    doc: Standard output with the search results.
  - id: output_file
    type: ['null', File]
    doc: Results file written with -O.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
stdout: fasta3_tfastm36.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasta3:36.3.8--0
