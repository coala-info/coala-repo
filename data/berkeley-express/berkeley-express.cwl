cwlVersion: v1.2
class: CommandLineTool
baseCommand: berkeley-express
label: berkeley-express
doc: "eXpress is a streaming tool for quantifying the abundance of a set of target
  sequences from sampled subsequences (RNA-Seq reads). In this Debian image the
  express program is installed as berkeley-express.\n\nTool homepage: https://github.com/adarob/eXpress"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - |-
        ${ return {"class": "Directory", "basename": inputs.output_dir_path, "listing": [], "writable": true}; }
inputs:
  - id: targets_fasta
    type: File
    doc: target sequence file in fasta format
    inputBinding:
      position: 1
  - id: sam_bam_file
    type: File
    doc: read alignment file in SAM or BAM format (reads grouped by name, not sorted
      by position)
    inputBinding:
      position: 2
  - id: output_dir_path
    type: string
    default: express_out
    doc: write all output files to this directory
    inputBinding:
      position: 103
      prefix: --output-dir
  - id: preprocess
    type:
      - 'null'
      - boolean
    doc: run preprocess script for eXpressD
    inputBinding:
      position: 103
      prefix: --preprocess
  - id: frag_len_mean
    type:
      - 'null'
      - int
    doc: prior estimate for average fragment length (default 200)
    inputBinding:
      position: 103
      prefix: --frag-len-mean
  - id: frag_len_stddev
    type:
      - 'null'
      - int
    doc: prior estimate for fragment length std deviation (default 80)
    inputBinding:
      position: 103
      prefix: --frag-len-stddev
  - id: haplotype_file
    type:
      - 'null'
      - File
    doc: path to a file containing haplotype pairs
    inputBinding:
      position: 103
      prefix: --haplotype-file
  - id: additional_batch
    type:
      - 'null'
      - int
    doc: number of additional batch EM rounds after initial online round (default 0)
    inputBinding:
      position: 103
      prefix: --additional-batch
  - id: additional_online
    type:
      - 'null'
      - int
    doc: number of additional online EM rounds after initial online round (default
      0)
    inputBinding:
      position: 103
      prefix: --additional-online
  - id: max_read_len
    type:
      - 'null'
      - int
    doc: maximum allowed length of a read (default 250)
    inputBinding:
      position: 103
      prefix: --max-read-len
  - id: output_align_prob
    type:
      - 'null'
      - boolean
    doc: output alignments (sam/bam) with probabilistic assignments
    inputBinding:
      position: 103
      prefix: --output-align-prob
  - id: output_align_samp
    type:
      - 'null'
      - boolean
    doc: output alignments (sam/bam) with sampled assignments
    inputBinding:
      position: 103
      prefix: --output-align-samp
  - id: fr_stranded
    type:
      - 'null'
      - boolean
    doc: accept only forward->reverse alignments (second-stranded protocols)
    inputBinding:
      position: 103
      prefix: --fr-stranded
  - id: rf_stranded
    type:
      - 'null'
      - boolean
    doc: accept only reverse->forward alignments (first-stranded protocols)
    inputBinding:
      position: 103
      prefix: --rf-stranded
  - id: f_stranded
    type:
      - 'null'
      - boolean
    doc: accept only forward single-end alignments (second-stranded protocols)
    inputBinding:
      position: 103
      prefix: --f-stranded
  - id: r_stranded
    type:
      - 'null'
      - boolean
    doc: accept only reverse single-end alignments (first-stranded protocols)
    inputBinding:
      position: 103
      prefix: --r-stranded
  - id: no_update_check
    type:
      - 'null'
      - boolean
    doc: disables automatic check for update via web
    inputBinding:
      position: 103
      prefix: --no-update-check
  - id: logtostderr
    type:
      - 'null'
      - boolean
    doc: prints all logging messages to stderr
    inputBinding:
      position: 103
      prefix: --logtostderr
  - id: forget_param
    type:
      - 'null'
      - float
    doc: sets the 'forgetting factor' parameter (0.5 < c <= 1, default 0.85)
    inputBinding:
      position: 103
      prefix: --forget-param
  - id: library_size
    type:
      - 'null'
      - long
    doc: specifies library size for FPKM instead of calculating from alignments
    inputBinding:
      position: 103
      prefix: --library-size
  - id: max_indel_size
    type:
      - 'null'
      - int
    doc: sets the maximum allowed indel size, affecting geometric indel prior (default
      10)
    inputBinding:
      position: 103
      prefix: --max-indel-size
  - id: calc_covar
    type:
      - 'null'
      - boolean
    doc: calculate and output covariance matrix
    inputBinding:
      position: 103
      prefix: --calc-covar
  - id: expr_alpha
    type:
      - 'null'
      - float
    doc: sets the strength of the prior, per bp (default 0.005)
    inputBinding:
      position: 103
      prefix: --expr-alpha
  - id: stop_at
    type:
      - 'null'
      - long
    doc: sets the number of fragments to process, disabled with 0
    inputBinding:
      position: 103
      prefix: --stop-at
  - id: burn_out
    type:
      - 'null'
      - long
    doc: sets number of fragments after which to stop updating auxiliary parameters
      (default 5000000)
    inputBinding:
      position: 103
      prefix: --burn-out
  - id: no_bias_correct
    type:
      - 'null'
      - boolean
    doc: disables bias correction
    inputBinding:
      position: 103
      prefix: --no-bias-correct
  - id: no_error_model
    type:
      - 'null'
      - boolean
    doc: disables error modelling
    inputBinding:
      position: 103
      prefix: --no-error-model
  - id: aux_param_file
    type:
      - 'null'
      - File
    doc: path to file containing auxiliary parameters to use instead of learning
    inputBinding:
      position: 103
      prefix: --aux-param-file
outputs:
  - id: output_dir
    type: Directory
    doc: The directory with the eXpress output files
    outputBinding:
      glob: $(inputs.output_dir_path)
  - id: results
    type: File
    doc: Abundance estimates per target (results.xprs)
    outputBinding:
      glob: $(inputs.output_dir_path)/results.xprs
  - id: params
    type:
      - 'null'
      - File
    doc: Learned auxiliary parameters (params.xprs)
    outputBinding:
      glob: $(inputs.output_dir_path)/params.xprs
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/berkeley-express:v1.5.1-3b1-deb_cv1
