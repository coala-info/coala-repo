cwlVersion: v1.2
class: CommandLineTool
baseCommand: rfmix
label: rfmix
doc: "RFMIX v2.03-r0 - Local Ancestry and Admixture Inference\n\nTool homepage: https://github.com/slowkoni/rfmix"
inputs:
  - id: analyze_range
    type:
      - 'null'
      - string
    doc: Physical position range, specified as <start pos>-<end pos>, in Mbp 
      (decimal allowed)
    inputBinding:
      position: 101
      prefix: --analyze-range=
      separate: false
  - id: bootstrap_mode
    type:
      - 'null'
      - int
    doc: Specify random forest bootstrap mode as integer code (see manual)
    inputBinding:
      position: 101
      prefix: --bootstrap-mode=
      separate: false
  - id: chromosome
    type: string
    doc: Execute only on specified chromosome
    inputBinding:
      position: 101
      prefix: --chromosome=
      separate: false
  - id: crf_spacing
    type:
      - 'null'
      - float
    doc: Conditional Random Field spacing (# of SNPs)
    inputBinding:
      position: 101
      prefix: --crf-spacing=
      separate: false
  - id: crf_weight
    type:
      - 'null'
      - float
    doc: Weight of observation term relative to transition term in conditional 
      random field
    inputBinding:
      position: 101
      prefix: --crf-weight=
      separate: false
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Turn on any debugging output
    inputBinding:
      position: 101
      prefix: --debug
  - id: em_iterations
    type:
      - 'null'
      - int
    doc: Maximum number of EM iterations
    inputBinding:
      position: 101
      prefix: --em-iterations=
      separate: false
  - id: generations
    type:
      - 'null'
      - float
    doc: Average number of generations since expected admixture
    inputBinding:
      position: 101
      prefix: --generations=
      separate: false
  - id: genetic_map
    type: File
    doc: Genetic map file
    inputBinding:
      position: 101
      prefix: --genetic-map=
      separate: false
  - id: max_missing
    type:
      - 'null'
      - float
    doc: Maximum proportion of missing data allowed to include a SNP
    inputBinding:
      position: 101
      prefix: --max-missing=
      separate: false
  - id: n_threads
    type:
      - 'null'
      - int
    doc: Force number of simultaneous thread for parallel execution
    inputBinding:
      position: 101
      prefix: --n-threads=
      separate: false
  - id: node_size
    type:
      - 'null'
      - int
    doc: Terminal node size for random forest trees
    inputBinding:
      position: 101
      prefix: --node-size=
      separate: false
  - id: output_basename
    type: string
    doc: Basename (prefix) for output files
    inputBinding:
      position: 101
      prefix: --output-basename=
      separate: false
  - id: query_file
    type: File
    doc: VCF file with samples to analyze
    inputBinding:
      position: 101
      prefix: --query-file=
      separate: false
  - id: random_seed
    type:
      - 'null'
      - string
    doc: Seed value for random number generation (integer) (maybe specified in 
      hexadecimal by preceeding with 0x), or the string "clock" to seed with the
      current system time.
    inputBinding:
      position: 101
      prefix: --random-seed=
      separate: false
  - id: reanalyze_reference
    type:
      - 'null'
      - boolean
    doc: In EM, analyze local ancestry of the reference panel and reclassify it
    inputBinding:
      position: 101
      prefix: --reanalyze-reference
  - id: reference_file
    type: File
    doc: VCF file with reference individuals
    inputBinding:
      position: 101
      prefix: --reference-file=
      separate: false
  - id: rf_minimum_snps
    type:
      - 'null'
      - int
    doc: With genetic sized rf windows, include at least this many SNPs 
      regardless of span
    inputBinding:
      position: 101
      prefix: --rf-minimum-snps=
      separate: false
  - id: rf_window_size
    type:
      - 'null'
      - float
    doc: Random forest window size (class estimation window size)
    inputBinding:
      position: 101
      prefix: --rf-window-size=
      separate: false
  - id: sample_map
    type: File
    doc: Reference panel sample population classification map
    inputBinding:
      position: 101
      prefix: --sample-map=
      separate: false
  - id: trees
    type:
      - 'null'
      - int
    doc: Number of tree in random forest to estimate population class 
      probability
    inputBinding:
      position: 101
      prefix: --trees=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: msp_file
    type: File
    doc: Maximum-likelihood ancestry assignment per window (.msp.tsv)
    outputBinding:
      glob: $(inputs.output_basename).msp.tsv
  - id: fb_file
    type: File
    doc: Forward-backward ancestry probabilities per site (.fb.tsv)
    outputBinding:
      glob: $(inputs.output_basename).fb.tsv
  - id: q_file
    type: File
    doc: Global ancestry estimates per sample (.rfmix.Q)
    outputBinding:
      glob: $(inputs.output_basename).rfmix.Q
  - id: sis_file
    type:
      - 'null'
      - File
    doc: Subpopulation (ancestry) inference summary (.sis.tsv)
    outputBinding:
      glob: $(inputs.output_basename).sis.tsv
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rfmix:2.03.r0.9505bfa--h503566f_8
stdout: rfmix.out
