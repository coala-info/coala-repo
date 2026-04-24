cwlVersion: v1.2
class: CommandLineTool
baseCommand: dialign-t
label: dialign-tx
doc: "Align sequences using the DIALIGN-T algorithm.\n\nTool homepage: https://dialign-tx.gobics.de"
inputs:
  - id: conf_directory
    type: Directory
    doc: Configuration directory containing score matrix and probability 
      distribution files.
    inputBinding:
      position: 1
  - id: fasta_file
    type: File
    doc: Input FASTA file containing sequences to align.
    inputBinding:
      position: 2
  - id: add_to_score
    type:
      - 'null'
      - int
    doc: Value to add to each score to prevent negative values.
    inputBinding:
      position: 103
      prefix: -v
  - id: anchor_file
    type:
      - 'null'
      - File
    doc: Optional anchor file.
    inputBinding:
      position: 103
      prefix: -A
  - id: calculate_overlap_weights
    type:
      - 'null'
      - int
    doc: 'Whether overlap weights are calculated or not. 0: no, 1: yes.'
    inputBinding:
      position: 103
      prefix: -o
  - id: compare_longest_orf
    type:
      - 'null'
      - boolean
    doc: Compare only longest Open Reading Frame. Do not use -D with this 
      option. Default values for PROTEIN input will be loaded.
    inputBinding:
      position: 103
      prefix: -L
  - id: debug_mode
    type:
      - 'null'
      - int
    doc: 'Debug mode level. 0: no debug, 1: current phase, 2: very loquacious, 5:
      hardcore debugging.'
    inputBinding:
      position: 103
      prefix: -d
  - id: even_threshold
    type:
      - 'null'
      - int
    doc: 'Even threshold for low score for sequences alignment. Defaults to PROTEIN:
      4, DNA: 0.'
    inputBinding:
      position: 103
      prefix: -t
  - id: fast_mode
    type:
      - 'null'
      - boolean
    doc: Fast mode (implies -l0, since it already significantly reduces 
      sensitivity).
    inputBinding:
      position: 103
      prefix: -F
  - id: generate_probability_table
    type:
      - 'null'
      - boolean
    doc: Generate probability table saved in <config_dir>/prob_table and exit.
    inputBinding:
      position: 103
      prefix: -C
  - id: global_min_fragment_length
    type:
      - 'null'
      - int
    doc: 'Global minimum fragment length for stop criterion. Defaults to PROTEIN:
      40, DNA: 40.'
    inputBinding:
      position: 103
      prefix: -g
  - id: input_is_dna
    type:
      - 'null'
      - boolean
    doc: Input is DNA sequence.
    inputBinding:
      position: 103
      prefix: -D
  - id: max_chars_per_line_input
    type:
      - 'null'
      - int
    doc: Maximum number of characters per line in an input FASTA file.
    inputBinding:
      position: 103
      prefix: -a
  - id: max_chars_per_line_output
    type:
      - 'null'
      - int
    doc: Maximum number of characters per line when printing a sequence.
    inputBinding:
      position: 103
      prefix: -c
  - id: max_consecutive_low_scoring_positions
    type:
      - 'null'
      - int
    doc: 'Maximum number of consecutive positions for a window containing low scoring
      positions. Defaults to PROTEIN: 4, DNA: 4.'
    inputBinding:
      position: 103
      prefix: -n
  - id: max_input_sequences
    type:
      - 'null'
      - int
    doc: Maximum amount of input sequences.
    inputBinding:
      position: 103
      prefix: -s
  - id: min_avg_score_in_frag_window
    type:
      - 'null'
      - float
    doc: 'Minimal allowed average score in fragment window containing low scoring
      positions. Defaults to PROTEIN: 4.0, DNA: 0.25.'
    inputBinding:
      position: 103
      prefix: -m
  - id: min_fragment_length
    type:
      - 'null'
      - int
    doc: Minimum fragment length.
    inputBinding:
      position: 103
      prefix: -f
  - id: min_weight
    type:
      - 'null'
      - float
    doc: Defines the minimum weight when the weight formula is changed to 
      1-pow(1-prob, factor).
    inputBinding:
      position: 103
      prefix: -w
  - id: neighbor_stripe_mode
    type:
      - 'null'
      - int
    doc: 'Neighbor stripe mode. 1: only use a sqrt(amount_of_seqs) stripe of neighbor
      sequences to calculate pairwise alignments (increase performance), 0: all pairwise
      alignments will be calculated.'
    inputBinding:
      position: 103
      prefix: -u
  - id: output_aminoacids
    type:
      - 'null'
      - boolean
    doc: 'Output in aminoacids, no retranslation of DNA sequences. Default: input
      = output.'
    inputBinding:
      position: 103
      prefix: -P
  - id: probability_distribution_file
    type:
      - 'null'
      - File
    doc: 'Probability distribution file name (in the configuration directory). Defaults
      to PROTEIN: BLOSUM.diag_prob_t10 or DNA: dna_diag_prob_100_exp_550000.'
    inputBinding:
      position: 103
      prefix: -p
  - id: score_matrix_file
    type:
      - 'null'
      - File
    doc: 'Score matrix file name (in the configuration directory). Defaults to PROTEIN:
      BLOSUM.scr or DNA: dna_matrix.scr.'
    inputBinding:
      position: 103
      prefix: -m
  - id: sensitivity_mode
    type:
      - 'null'
      - int
    doc: 'Sensitivity mode. Higher level means less likely spurious random fragments
      are aligned in local alignments. 0: switched off, 1: level-1, 2: level-2.'
    inputBinding:
      position: 103
      prefix: -l
  - id: threshold_weight
    type:
      - 'null'
      - float
    doc: Threshold weight to consider the fragment at all.
    inputBinding:
      position: 103
      prefix: -r
  - id: translate_dna_to_aa_full
    type:
      - 'null'
      - boolean
    doc: Translate DNA into aminoacids from begin to end (length will be cut to 
      mod 3 = 0). Do not use -D with this option. Default values for PROTEIN 
      input will be loaded.
    inputBinding:
      position: 103
      prefix: -T
  - id: translate_dna_to_aa_orf
    type:
      - 'null'
      - boolean
    doc: Translate DNA to aminoacids, reading frame for each sequence calculated
      due to its longest ORF. Do not use -D with this option. Default values for
      PROTEIN input will be loaded.
    inputBinding:
      position: 103
      prefix: -O
outputs:
  - id: fasta_out_file
    type:
      - 'null'
      - File
    doc: Optional output FASTA file for aligned sequences.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dialign-tx:v1.0.2-12-deb_cv1
