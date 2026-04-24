cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rbpbench
  - streme
label: rbpbench_streme
doc: "Run STREME on RBP-bound sequences\n\nTool homepage: https://github.com/michauhl/RBPBench"
inputs:
  - id: input_sequences
    type: File
    doc: 'Provide primary (positive) sequences FASTA file (STREME option: --p)'
    inputBinding:
      position: 101
      prefix: --in
  - id: negative_input_sequences
    type:
      - 'null'
      - File
    doc: 'Provide control (negative) sequences FASTA file. By default, shuffled --in
      positive sequences are used as control sequences (STREME option: --n)'
    inputBinding:
      position: 101
      prefix: --neg-in
  - id: output_folder
    type: Directory
    doc: Results output folder
    inputBinding:
      position: 101
      prefix: --out
  - id: streme_background_frequencies_file
    type:
      - 'null'
      - File
    doc: 'Provide STREME nucleotide frequencies (STREME option: --bfile) file (default:
      use internal frequencies file, define which with --streme-ntf-mode)'
    inputBinding:
      position: 101
      prefix: --streme-bfile
  - id: streme_background_model_order
    type:
      - 'null'
      - int
    doc: 'Estimates an m-order background model for scoring sites and uses an m-order
      shuffle if creating control sequences from primary sequences. Default for RNA/DNA:
      2 (STREME option: --order) (default: 2)'
    inputBinding:
      position: 101
      prefix: --streme-order
  - id: streme_max_motif_width
    type:
      - 'null'
      - int
    doc: 'Maximum width for motifs (must be <= 30) (STREME option: --maxw) (default:
      15)'
    inputBinding:
      position: 101
      prefix: --streme-maxw
  - id: streme_min_motif_width
    type:
      - 'null'
      - int
    doc: 'Minimum width for motifs (must be >= 3) (STREME option: --minw) (default:
      6)'
    inputBinding:
      position: 101
      prefix: --streme-minw
  - id: streme_nucleotide_frequency_mode
    type:
      - 'null'
      - string
    doc: 'Set which internal nucleotide frequencies to use for STREME. 1: use frequencies
      from human ENSEMBL transcripts (excluding introns, with A most prominent) 2:
      use frequencies from human ENSEMBL transcripts (including introns, resulting
      in lower G+C and T most prominent) 3: use uniform frequencies (same for every
      nucleotide) (default: 1)'
    inputBinding:
      position: 101
      prefix: --streme-ntf-mode
  - id: streme_random_seed
    type:
      - 'null'
      - int
    doc: 'Random seed for shuffling sequences (STREME option: --seed) (default: 0)'
    inputBinding:
      position: 101
      prefix: --streme-seed
  - id: streme_significance_threshold
    type:
      - 'null'
      - float
    doc: 'STREME significance threshold (p-value) for reporting enriched motifs (STREME
      option --thresh) (default: 0.05)'
    inputBinding:
      position: 101
      prefix: --streme-thresh
  - id: streme_use_evalue_threshold
    type:
      - 'null'
      - boolean
    doc: 'Use E-value threshold instead of p-value (STREME option: --evalue) (default:
      False)'
    inputBinding:
      position: 101
      prefix: --streme-evalue
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
stdout: rbpbench_streme.out
