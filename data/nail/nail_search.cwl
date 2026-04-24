cwlVersion: v1.2
class: CommandLineTool
baseCommand: nail search
label: nail_search
doc: "Run nail's protein search pipeline\n\nTool homepage: https://github.com/TravisWheelerLab/nail"
inputs:
  - id: query_database
    type: File
    doc: The query database file
    inputBinding:
      position: 1
  - id: target_database
    type: File
    doc: The target database file
    inputBinding:
      position: 2
  - id: allow_overwrite
    type:
      - 'null'
      - boolean
    doc: Allow nail to overwrite files
    inputBinding:
      position: 103
      prefix: --allow-overwrite
  - id: cloud_alpha
    type:
      - 'null'
      - float
    doc: 'Cloud search parameter α: local score pruning threshold'
    inputBinding:
      position: 103
      prefix: -A
  - id: cloud_beta
    type:
      - 'null'
      - float
    doc: 'Cloud search parameter β: global score pruning threshold'
    inputBinding:
      position: 103
      prefix: -B
  - id: cloud_gamma
    type:
      - 'null'
      - int
    doc: 'Cloud search parameter γ: at minimum, compute N anti-diagonals'
    inputBinding:
      position: 103
      prefix: -G
  - id: cloud_threshold
    type:
      - 'null'
      - float
    doc: 'Cloud search threshold: filter hits with P-value > X'
    inputBinding:
      position: 103
      prefix: -C
  - id: double_seed
    type:
      - 'null'
      - boolean
    doc: Seed alignments twice (high/low expected sequence divergence)
    inputBinding:
      position: 103
      prefix: --double-seed
  - id: final_reporting_threshold
    type:
      - 'null'
      - float
    doc: 'Final reporting threshold: filter hits with E-value > X'
    inputBinding:
      position: 103
      prefix: -E
  - id: forward_filter_threshold
    type:
      - 'null'
      - float
    doc: 'Forward filter threshold: filter hits with P-value > X'
    inputBinding:
      position: 103
      prefix: -F
  - id: mmseqs_k
    type:
      - 'null'
      - int
    doc: 'MMseqs2 prefilter: k-mer length (0: automatically set to optimum)'
    inputBinding:
      position: 103
      prefix: --mmseqs-k
  - id: mmseqs_k_score
    type:
      - 'null'
      - int
    doc: 'MMseqs2 prefilter: k-mer threshold for generating similar k-mer lists'
    inputBinding:
      position: 103
      prefix: --mmseqs-k-score
  - id: mmseqs_max_seqs
    type:
      - 'null'
      - int
    doc: 'MMseqs2 prefilter: Maximum results per query sequence allowed to pass the
      prefilter'
    inputBinding:
      position: 103
      prefix: --mmseqs-max-seqs
  - id: mmseqs_min_ungapped_score
    type:
      - 'null'
      - int
    doc: 'MMseqs2 prefilter: Accept only matches with ungapped alignment score above
      threshold'
    inputBinding:
      position: 103
      prefix: --mmseqs-min-ungapped-score
  - id: no_null2
    type:
      - 'null'
      - boolean
    doc: Don't compute sequence composition bias score correction
    inputBinding:
      position: 103
      prefix: --no-null2
  - id: no_tabular_results
    type:
      - 'null'
      - boolean
    doc: Don't write any tabular results, write alignments to stdout
    inputBinding:
      position: 103
      prefix: -x
  - id: only_seed
    type:
      - 'null'
      - boolean
    doc: Produce alignment seeds and terminate
    inputBinding:
      position: 103
      prefix: --only-seed
  - id: override_evalue_comparisons
    type:
      - 'null'
      - int
    doc: Override the number of comparisons used for E-value calculation
    inputBinding:
      position: 103
      prefix: -Z
  - id: print_summary_statistics
    type:
      - 'null'
      - boolean
    doc: Print out pipeline summary statistics
    inputBinding:
      position: 103
      prefix: -s
  - id: seeding_filter_threshold
    type:
      - 'null'
      - float
    doc: 'Seeding filter threshold: filter hits with P-value > X'
    inputBinding:
      position: 103
      prefix: -S
  - id: seeds
    type:
      - 'null'
      - File
    doc: A file containing pre-computed alignment seeds
    inputBinding:
      position: 103
      prefix: --seeds
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads that nail will use
    inputBinding:
      position: 103
      prefix: -t
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: The directory where intermediate files will be placed
    inputBinding:
      position: 103
      prefix: --tmp-dir
outputs:
  - id: tbl_out
    type:
      - 'null'
      - File
    doc: The file where tabular output will be written
    outputBinding:
      glob: $(inputs.tbl_out)
  - id: ali_out
    type:
      - 'null'
      - File
    doc: The file where alignment output will be written
    outputBinding:
      glob: $(inputs.ali_out)
  - id: seeds_out
    type:
      - 'null'
      - File
    doc: The file where alignment seeds will be written
    outputBinding:
      glob: $(inputs.seeds_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nail:0.4.0--h4349ce8_1
