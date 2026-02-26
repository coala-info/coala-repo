cwlVersion: v1.2
class: CommandLineTool
baseCommand: predicthaplo
label: predicthaplo
doc: "This software aims at reconstructing haplotypes from next-generation sequencing
  data.\n\nTool homepage: https://github.com/cbg-ethz/PredictHaplo"
inputs:
  - id: alpha_mn_local
    type:
      - 'null'
      - float
    doc: Prior parameter for multinomial tables over the nucleotides.
    inputBinding:
      position: 101
      prefix: --alpha_MN_local
  - id: cluster_number
    type:
      - 'null'
      - int
    doc: Max number of clusters (in the truncated Dirichlet process).
    inputBinding:
      position: 101
      prefix: --cluster_number
  - id: do_local_analysis
    type:
      - 'null'
      - int
    doc: do_local_analysis (1 = true, 0 = false) (must be 1 in the first run).
    inputBinding:
      position: 101
      prefix: --do_local_Analysis
  - id: entropy_threshold
    type:
      - 'null'
      - float
    doc: '...'
    inputBinding:
      position: 101
      prefix: --entropy_threshold
  - id: have_true_haplotypes
    type:
      - 'null'
      - int
    doc: have_true_haplotypes (1 = true, 0 = false).
    inputBinding:
      position: 101
      prefix: --have_true_haplotypes
  - id: include_deletions
    type:
      - 'null'
      - int
    doc: Include deletions (0 = no, 1 = yes).
    inputBinding:
      position: 101
      prefix: --include_deletions
  - id: local_window_size_factor
    type:
      - 'null'
      - float
    doc: Size of  local reconstruction window relative to the median of the read
      lengths.
    inputBinding:
      position: 101
      prefix: --local_window_size_factor
  - id: max_gap_fraction
    type:
      - 'null'
      - float
    doc: Relative to alignment length.
    inputBinding:
      position: 101
      prefix: --max_gap_fraction
  - id: max_reads_in_window
    type:
      - 'null'
      - int
    doc: '...'
    inputBinding:
      position: 101
      prefix: --max_reads_in_window
  - id: min_align_score_fraction
    type:
      - 'null'
      - float
    doc: Relative to read length.
    inputBinding:
      position: 101
      prefix: --min_align_score_fraction
  - id: min_mapping_qual
    type:
      - 'null'
      - int
    doc: '...'
    inputBinding:
      position: 101
      prefix: --min_mapping_qual
  - id: min_overlap_factor
    type:
      - 'null'
      - float
    doc: Reads must have an overlap with the local reconstruction window of at 
      least this factor times the window size.
    inputBinding:
      position: 101
      prefix: --min_overlap_factor
  - id: min_readlength
    type:
      - 'null'
      - int
    doc: '...'
    inputBinding:
      position: 101
      prefix: --min_readlength
  - id: nsample
    type:
      - 'null'
      - int
    doc: MCMC iterations.
    inputBinding:
      position: 101
      prefix: --nSample
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix of output files.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: reconstruction_start
    type:
      - 'null'
      - int
    doc: '...'
    inputBinding:
      position: 101
      prefix: --reconstruction_start
  - id: reconstruction_stop
    type:
      - 'null'
      - int
    doc: '...'
    inputBinding:
      position: 101
      prefix: --reconstruction_stop
  - id: reference_file
    type: File
    doc: Filename of reference sequence (FASTA).
    inputBinding:
      position: 101
      prefix: --reference
  - id: sam_file
    type: File
    doc: Filename of the aligned reads (sam format).
    inputBinding:
      position: 101
      prefix: --sam
  - id: true_haplotypes_file
    type:
      - 'null'
      - File
    doc: Filename of the true haplotypes (MSA in FASTA format) (fill in any 
      dummy filename if there is no "true" haplotypes).
    inputBinding:
      position: 101
      prefix: --true_haplotypes
  - id: visualization_level
    type:
      - 'null'
      - int
    doc: do_visualize (1 = true, 0 = false).
    inputBinding:
      position: 101
      prefix: --visualization_level
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/predicthaplo:2.1.4--h9b88814_6
stdout: predicthaplo.out
