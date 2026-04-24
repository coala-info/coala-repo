cwlVersion: v1.2
class: CommandLineTool
baseCommand: yass
label: yass
doc: "YASS (Yet Another Sequence Searcher) is a tool for finding similarities between
  sequences.\n\nTool homepage: https://bioinfo.lifl.fr/yass"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: One or more input FASTA files (file.mfas)
    inputBinding:
      position: 1
  - id: cost_penalties
    type:
      - 'null'
      - string
    doc: Reset match/mismatch/transistion/other Costs (penalties). You can also 
      give the 16 values of matrix (ACGT order).
    inputBinding:
      position: 102
      prefix: -C
  - id: display_mode
    type:
      - 'null'
      - int
    doc: 'Display mode for alignment output. 0: Display alignment positions (kept
      for compatibility), 1: Display alignment positions + alignments + stats (default),
      2: Display blast-like tabular output, 3: Display light tabular output (better
      for post-processing), 4: Display BED file output, 5: Display PSL file output'
    inputBinding:
      position: 102
      prefix: -d
  - id: evalue_threshold
    type:
      - 'null'
      - int
    doc: E-value threshold
    inputBinding:
      position: 102
      prefix: -E
  - id: forbid_close_regions_distance
    type:
      - 'null'
      - int
    doc: Forbid aligning too close regions (e.g. Tandem repeats). Valid for 
      single sequence comparison only. Default 16 bp
    inputBinding:
      position: 102
      prefix: -T
  - id: gap_penalties
    type:
      - 'null'
      - string
    doc: Reset Gap opening/extension penalties
    inputBinding:
      position: 102
      prefix: -G
  - id: gumbel_parameters
    type:
      - 'null'
      - string
    doc: Reset Lambda and K parameters of Gumbel law
    inputBinding:
      position: 102
      prefix: -L
  - id: indel_rate
    type:
      - 'null'
      - int
    doc: Indel rate (%)
    inputBinding:
      position: 102
      prefix: -i
  - id: low_complexity_filter_entropy
    type:
      - 'null'
      - float
    doc: 'Low complexity filter: minimal allowed Entropy of trinucleotide distribution,
      ranging between 0 (no filter) and 6'
    inputBinding:
      position: 102
      prefix: -e
  - id: mask_lowercase
    type:
      - 'null'
      - boolean
    doc: Mask lowercase regions (seed algorithm only)
    inputBinding:
      position: 102
      prefix: -l
  - id: memory_limit_ungapped_alignments
    type:
      - 'null'
      - int
    doc: Memory limit of the number of ungapped alignments
    inputBinding:
      position: 102
      prefix: -O
  - id: mutation_rate
    type:
      - 'null'
      - int
    doc: Mutation rate (%)
    inputBinding:
      position: 102
      prefix: -m
  - id: scoring_matrix
    type:
      - 'null'
      - int
    doc: 'Select a scoring Matrix (default 3). Format: [Match,Transversion,Transition],(Gopen,Gext).
      0: [1, -3, -2],(-8, -2), 1: [2, -3, -2],(-12, -4), 2: [3, -3, -2],(-16, -4),
      3: [5, -4, -3],(-16, -4), 4: [5, -4, -2],(-16, -4)'
    inputBinding:
      position: 102
      prefix: -M
  - id: seed_hit_criterion
    type:
      - 'null'
      - int
    doc: 'Seed hit Criterion: 1 or 2 seeds to consider a hit'
    inputBinding:
      position: 102
      prefix: -c
  - id: seed_patterns
    type:
      - 'null'
      - string
    doc: "Seed Pattern(s). Use '#' for match, '@' for match or transition, '-' or
      '_' for joker, ',' for seed separator (max: 32 seeds)."
    inputBinding:
      position: 102
      prefix: -p
  - id: select_sequence_first_multifasta
    type:
      - 'null'
      - int
    doc: Select sequence from the first multi-fasta file. Use 0 to select the 
      full first multi-fasta file
    inputBinding:
      position: 102
      prefix: -S
  - id: sort_order
    type:
      - 'null'
      - int
    doc: 'Sort according to: 0: alignment scores, 1: entropy, 2: mutual information
      (experimental), 3: both entropy and score, 4: positions on the 1st file, 5:
      positions on the 2nd file, 6: alignment % id, 7: 1st file sequence % id, 8:
      2nd file sequence % id, 10-18: (0-8) + sort by "first fasta-chunk order", 20-28:
      (0-8) + sort by "second fasta-chunk order", 30-38: (0-8) + sort by "both first/second
      chunks order", 40-48: equivalent to (10-18) where "best score for fst fasta-chunk"
      replaces "...", 50-58: equivalent to (20-28) where "best score for snd fasta-chunk"
      replaces "...", 60-68: equivalent to (70-78), where "sort by best score of fst
      fasta-chunk" replaces "...", 70-78: BLAST-like behavior : "keep fst fasta-chunk
      order", then trigger all hits for all good snd fasta-chunk, 80-88: equivalent
      to (30-38) where "best score for fst/snd fasta-chunk" replaces "..."'
    inputBinding:
      position: 102
      prefix: -s
  - id: statistical_tolerance_alpha
    type:
      - 'null'
      - int
    doc: Statistical tolerance Alpha (%)
    inputBinding:
      position: 102
      prefix: -a
  - id: strand_processing
    type:
      - 'null'
      - int
    doc: 'Strand to process. 0: process forward (query) strand, 1: process Reverse
      complement strand, 2: process both forward and Reverse complement strands (default)'
    inputBinding:
      position: 102
      prefix: -r
  - id: trim_overrepresented_seeds_codes
    type:
      - 'null'
      - float
    doc: Trim out over-represented seeds codes, ranging between 0.0 (no trim) 
      and +inf
    inputBinding:
      position: 102
      prefix: -t
  - id: window_range
    type:
      - 'null'
      - string
    doc: Window <min,max> range for post-processing and grouping alignments
    inputBinding:
      position: 102
      prefix: -W
  - id: window_size_coefficient
    type:
      - 'null'
      - float
    doc: 'Window size coefficient for post-processing and grouping alignments. NOTE:
      -w 0 disables post-processing'
    inputBinding:
      position: 102
      prefix: -w
  - id: xdrop_threshold
    type:
      - 'null'
      - int
    doc: Xdrop threshold score
    inputBinding:
      position: 102
      prefix: -X
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yass:1.16--h7b50bb2_0
