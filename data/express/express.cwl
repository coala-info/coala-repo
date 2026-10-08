cwlVersion: v1.2
class: CommandLineTool
baseCommand: express
label: express
doc: "eXpress: streaming quantification for high-throughput sequencing. Estimates abundances of target sequences (for example transcripts) from read alignments in SAM or BAM format.\n\nTool homepage: https://pachterlab.github.io/eXpress/"
inputs:
  - id: target_fasta
    type: File
    doc: Target sequence file in fasta format
    inputBinding:
      position: 201
  - id: hits
    type: File
    doc: Read alignment file in SAM or BAM format
    inputBinding:
      position: 202
  - id: output_dir
    type:
      - 'null'
      - string
    doc: "Write all output files to this directory (-o). The directory is created in the work directory."
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: preprocess
    type:
      - 'null'
      - boolean
    doc: "Run preprocess script for eXpressD"
    inputBinding:
      position: 101
      prefix: --preprocess
  - id: frag_len_mean
    type:
      - 'null'
      - int
    doc: "Prior estimate for average fragment length"
    inputBinding:
      position: 101
      prefix: --frag-len-mean
  - id: frag_len_stddev
    type:
      - 'null'
      - int
    doc: "Prior estimate for fragment length standard deviation"
    inputBinding:
      position: 101
      prefix: --frag-len-stddev
  - id: haplotype_file
    type:
      - 'null'
      - File
    doc: "Path to a file containing haplotype pairs"
    inputBinding:
      position: 101
      prefix: --haplotype-file
  - id: additional_batch
    type:
      - 'null'
      - int
    doc: "Number of additional batch EM rounds after initial online round"
    inputBinding:
      position: 101
      prefix: --additional-batch
  - id: additional_online
    type:
      - 'null'
      - int
    doc: "Number of additional online EM rounds after initial online round"
    inputBinding:
      position: 101
      prefix: --additional-online
  - id: max_read_len
    type:
      - 'null'
      - int
    doc: "Maximum allowed length of a read"
    inputBinding:
      position: 101
      prefix: --max-read-len
  - id: output_align_prob
    type:
      - 'null'
      - boolean
    doc: "Output alignments (sam/bam) with probabilistic assignments"
    inputBinding:
      position: 101
      prefix: --output-align-prob
  - id: output_align_samp
    type:
      - 'null'
      - boolean
    doc: "Output alignments (sam/bam) with sampled assignments"
    inputBinding:
      position: 101
      prefix: --output-align-samp
  - id: fr_stranded
    type:
      - 'null'
      - boolean
    doc: "Accept only forward->reverse alignments (second-stranded protocols)"
    inputBinding:
      position: 101
      prefix: --fr-stranded
  - id: rf_stranded
    type:
      - 'null'
      - boolean
    doc: "Accept only reverse->forward alignments (first-stranded protocols)"
    inputBinding:
      position: 101
      prefix: --rf-stranded
  - id: f_stranded
    type:
      - 'null'
      - boolean
    doc: "Accept only forward single-end alignments (second-stranded protocols)"
    inputBinding:
      position: 101
      prefix: --f-stranded
  - id: r_stranded
    type:
      - 'null'
      - boolean
    doc: "Accept only reverse single-end alignments (first-stranded protocols)"
    inputBinding:
      position: 101
      prefix: --r-stranded
  - id: no_update_check
    type:
      - 'null'
      - boolean
    doc: "Disables automatic check for update via web"
    inputBinding:
      position: 101
      prefix: --no-update-check
  - id: logtostderr
    type:
      - 'null'
      - boolean
    doc: "Prints all logging messages to stderr"
    inputBinding:
      position: 101
      prefix: --logtostderr
  - id: forget_param
    type:
      - 'null'
      - float
    doc: "Sets the forgetting factor parameter (0.5 < c <= 1)"
    inputBinding:
      position: 101
      prefix: --forget-param
  - id: library_size
    type:
      - 'null'
      - int
    doc: "Specifies library size for FPKM instead of calculating from alignments"
    inputBinding:
      position: 101
      prefix: --library-size
  - id: max_indel_size
    type:
      - 'null'
      - int
    doc: "Sets the maximum allowed indel size, affecting geometric indel prior"
    inputBinding:
      position: 101
      prefix: --max-indel-size
  - id: calc_covar
    type:
      - 'null'
      - boolean
    doc: "Calculate and output covariance matrix"
    inputBinding:
      position: 101
      prefix: --calc-covar
  - id: expr_alpha
    type:
      - 'null'
      - float
    doc: "Sets the strength of the prior, per bp"
    inputBinding:
      position: 101
      prefix: --expr-alpha
  - id: stop_at
    type:
      - 'null'
      - int
    doc: "Sets the number of fragments to process, disabled with 0"
    inputBinding:
      position: 101
      prefix: --stop-at
  - id: burn_out
    type:
      - 'null'
      - int
    doc: "Sets number of fragments after which to stop updating auxiliary parameters"
    inputBinding:
      position: 101
      prefix: --burn-out
  - id: no_bias_correct
    type:
      - 'null'
      - boolean
    doc: "Disables bias correction"
    inputBinding:
      position: 101
      prefix: --no-bias-correct
  - id: no_error_model
    type:
      - 'null'
      - boolean
    doc: "Disables error modelling"
    inputBinding:
      position: 101
      prefix: --no-error-model
  - id: aux_param_file
    type:
      - 'null'
      - File
    doc: "Path to file containing auxiliary parameters to use instead of learning"
    inputBinding:
      position: 101
      prefix: --aux-param-file
outputs:
  - id: results
    type: File
    doc: Abundance estimates per target sequence (results.xprs)
    outputBinding:
      glob: "$(inputs.output_dir ? inputs.output_dir + '/results.xprs' : 'results.xprs')"
  - id: params
    type: File
    doc: Learned parameters (params.xprs)
    outputBinding:
      glob: "$(inputs.output_dir ? inputs.output_dir + '/params.xprs' : 'params.xprs')"
  - id: covariance
    type:
      - 'null'
      - File
    doc: Covariance matrix (varcov.xprs), written with --calc-covar
    outputBinding:
      glob: "$(inputs.output_dir ? inputs.output_dir + '/varcov.xprs' : 'varcov.xprs')"
  - id: alignments
    type:
      type: array
      items: File
    doc: Alignments with probabilistic or sampled assignments, written with --output-align-prob or --output-align-samp
    outputBinding:
      glob: "$(inputs.output_dir ? inputs.output_dir + '/hits.*.*am' : 'hits.*.*am')"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - '$(inputs.output_dir ? {"class": "Directory", "basename": inputs.output_dir, "listing": []} : null)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/express:1.5.1--h2d50403_1
