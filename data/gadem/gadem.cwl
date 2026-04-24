cwlVersion: v1.2
class: CommandLineTool
baseCommand: gadem
label: gadem
doc: "a motif discovery tool for large-scale sequence data\n\nTool homepage: https://www.niehs.nih.gov/research/resources/software/biostatistics/gadem/index.cfm"
inputs:
  - id: background_model_file
    type:
      - 'null'
      - File
    doc: File name for background model. The current version only supports 0-th 
      Markov background model.
    inputBinding:
      position: 101
      prefix: -bfile
  - id: e_value_cutoff
    type:
      - 'null'
      - float
    doc: ln(E-value) cutoff for selecting MOTIFS.
    inputBinding:
      position: 101
      prefix: -ev
  - id: em_steps
    type:
      - 'null'
      - int
    doc: Number of EM steps. Set to 0 to scan sequences with a PWM.
    inputBinding:
      position: 101
      prefix: -em
  - id: extend_trim
    type:
      - 'null'
      - int
    doc: Base extension and trimming (1 -yes, 0 -no).
    inputBinding:
      position: 101
      prefix: -extTrim
  - id: fraction_seq_em
    type:
      - 'null'
      - float
    doc: Fraction of sequences used in EM to obtain PWMs in an unseeded 
      analysis.
    inputBinding:
      position: 101
      prefix: -fEM
  - id: full_scan
    type:
      - 'null'
      - int
    doc: 0 (default) - scan masked sequences in S (disallow motif site overlap).
      1 - scan unmasked sequences in S (allow motif sites to overlap).
    inputBinding:
      position: 101
      prefix: -fullScan
  - id: ga_generations
    type:
      - 'null'
      - int
    doc: Number of genetic algorithm (GA) generations.
    inputBinding:
      position: 101
      prefix: -gen
  - id: ga_population_size
    type:
      - 'null'
      - int
    doc: GA population size.
    inputBinding:
      position: 101
      prefix: -pop
  - id: mask_repetitive
    type:
      - 'null'
      - int
    doc: 'Mask repetitive, low-complexity sequences (default: 0-no masking, 1-masking).'
    inputBinding:
      position: 101
      prefix: -maskR
  - id: max_gap_spaced_dyads
    type:
      - 'null'
      - int
    doc: Maximal number of unspecified nucleotides in spaced dyads.
    inputBinding:
      position: 101
      prefix: -maxgap
  - id: max_motifs
    type:
      - 'null'
      - int
    doc: Maximal number of motifs sought.
    inputBinding:
      position: 101
      prefix: -nmotifs
  - id: max_pentamers_spaced_dyads
    type:
      - 'null'
      - int
    doc: Number of top-ranked pentamers for spaced dyads.
    inputBinding:
      position: 101
      prefix: -maxw5
  - id: max_tetramers_spaced_dyads
    type:
      - 'null'
      - int
    doc: Number of top-ranked tetramers for spaced dyads.
    inputBinding:
      position: 101
      prefix: -maxw4
  - id: max_trimers_spaced_dyads
    type:
      - 'null'
      - int
    doc: Number of top-ranked trimers for spaced dyads.
    inputBinding:
      position: 101
      prefix: -maxw3
  - id: min_gap_spaced_dyads
    type:
      - 'null'
      - int
    doc: Minimal number of unspecified nucleotides in spaced dyads.
    inputBinding:
      position: 101
      prefix: -mingap
  - id: min_sites
    type:
      - 'null'
      - int
    doc: 'Minimal number of sites required for a motif to be reported (default: numSeq/20).'
    inputBinding:
      position: 101
      prefix: -minN
  - id: num_simulated_sequences
    type:
      - 'null'
      - int
    doc: Number of sets of randomly simulated sequences.
    inputBinding:
      position: 101
      prefix: -nbs
  - id: output_file
    type:
      - 'null'
      - File
    doc: Name of main GADEM output file.
    inputBinding:
      position: 101
      prefix: -fout
  - id: output_pwm_file
    type:
      - 'null'
      - File
    doc: Name of output PWM file in STAMP format.
    inputBinding:
      position: 101
      prefix: -fpwm
  - id: p_value_cutoff
    type:
      - 'null'
      - float
    doc: P-value cutoff for declaring BINDING SITES.
    inputBinding:
      position: 101
      prefix: -pv
  - id: pos_weight
    type:
      - 'null'
      - int
    doc: Weight profile for positions on the sequence (0 - no weight, 1 - 
      gaussian prior, 2 - triangular prior). Default is 1.
    inputBinding:
      position: 101
      prefix: -posWt
  - id: pos_weight_width
    type:
      - 'null'
      - int
    doc: For -posWt 1 or 2, width of central sequence region with large EM 
      weights for PWM optimization. Ignored when -posWt is 0.
    inputBinding:
      position: 101
      prefix: -widthWt
  - id: seed_pwm_file
    type:
      - 'null'
      - File
    doc: File name for the seed PWM, when a 'seeded' approach is used.
    inputBinding:
      position: 101
      prefix: -fpwm0
  - id: seq_file
    type: File
    doc: Input sequence file
    inputBinding:
      position: 101
      prefix: -fseq
  - id: use_score
    type:
      - 'null'
      - int
    doc: Use top-scoring sequences for deriving PWMs. 0 - no (default), 1 - yes.
    inputBinding:
      position: 101
      prefix: -useScore
  - id: verbose
    type:
      - 'null'
      - int
    doc: Print immediate results on screen [1-yes (default), 0-no].
    inputBinding:
      position: 101
      prefix: -verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gadem:1.3.1--h7b50bb2_8
stdout: gadem.out
