cwlVersion: v1.2
class: CommandLineTool
baseCommand: [popscle, freemuxlet]
label: popscle_freemuxlet
doc: "Genotype-free deconvolution of multiplexed single-cell RNA-seq over multiple individuals.\n\nTool homepage: https://github.com/statgen/popscle"
inputs:
  - id: plp
    type: string
    doc: "Prefix of the input pileup files (<prefix>.plp.gz, .var.gz, .cel.gz, .umi.gz)"
    inputBinding:
      position: 1
      prefix: --plp
  - id: init_cluster
    type:
      - 'null'
      - File
    doc: "Input file containing the initial cluster information"
    inputBinding:
      position: 1
      prefix: --init-cluster
  - id: out
    type: string
    doc: "Output file prefix"
    inputBinding:
      position: 1
      prefix: --out
  - id: nsample
    type:
      - 'null'
      - int
    doc: "Number of samples multiplexed together Default: 0"
    inputBinding:
      position: 1
      prefix: --nsample
  - id: aux_files
    type:
      - 'null'
      - boolean
    doc: "Turn on writing auxilary output files Default: OFF"
    inputBinding:
      position: 1
      prefix: --aux-files
  - id: verbose
    type:
      - 'null'
      - int
    doc: "Turn on verbose mode with specific verbosity threshold. 0: fully verbose, 100 : no verbose messages Default: 100"
    inputBinding:
      position: 1
      prefix: --verbose
  - id: doublet_prior
    type:
      - 'null'
      - float
    doc: "Prior of doublet Default: 0.50"
    inputBinding:
      position: 1
      prefix: --doublet-prior
  - id: geno_error
    type:
      - 'null'
      - float
    doc: "Genotype error parameter per cluster Default: 0.10"
    inputBinding:
      position: 1
      prefix: --geno-error
  - id: bf_thres
    type:
      - 'null'
      - float
    doc: "Bayes Factor Threshold used in the initial clustering Default: 5.41"
    inputBinding:
      position: 1
      prefix: --bf-thres
  - id: frac_init_clust
    type:
      - 'null'
      - float
    doc: "Fraction of droplets to be clustered in the very first round of initial clustering procedure Default: 1.00"
    inputBinding:
      position: 1
      prefix: --frac-init-clust
  - id: iter_init
    type:
      - 'null'
      - int
    doc: "Iteration for initial cluster assignment (set to zero to skip the iterations) Default: 10"
    inputBinding:
      position: 1
      prefix: --iter-init
  - id: keep_init_missing
    type:
      - 'null'
      - boolean
    doc: "Keep missing cluster assignment as missing in the initial iteration Default: OFF"
    inputBinding:
      position: 1
      prefix: --keep-init-missing
  - id: randomize_singlet_score
    type:
      - 'null'
      - boolean
    doc: "Randomize the singlet scores to test its effect Default: OFF"
    inputBinding:
      position: 1
      prefix: --randomize-singlet-score
  - id: seed
    type:
      - 'null'
      - int
    doc: "Seed for random number (use clocks if not set) Default: 0"
    inputBinding:
      position: 1
      prefix: --seed
  - id: cap_bq
    type:
      - 'null'
      - int
    doc: "Maximum base quality (higher BQ will be capped) Default: 20"
    inputBinding:
      position: 1
      prefix: --cap-BQ
  - id: min_bq
    type:
      - 'null'
      - int
    doc: "Minimum base quality to consider (lower BQ will be skipped) Default: 13"
    inputBinding:
      position: 1
      prefix: --min-BQ
  - id: group_list
    type:
      - 'null'
      - File
    doc: "List of tag readgroup/cell barcode to consider in this run. All other barcodes will be ignored. This is useful for parallelized run"
    inputBinding:
      position: 1
      prefix: --group-list
  - id: min_total
    type:
      - 'null'
      - int
    doc: "Minimum number of total reads for a droplet/cell to be considered Default: 0"
    inputBinding:
      position: 1
      prefix: --min-total
  - id: min_umi
    type:
      - 'null'
      - int
    doc: "Minimum number of UMIs for a droplet/cell to be considered Default: 0"
    inputBinding:
      position: 1
      prefix: --min-umi
  - id: min_snp
    type:
      - 'null'
      - int
    doc: "Minimum number of SNPs with coverage for a droplet/cell to be considered Default: 0"
    inputBinding:
      position: 1
      prefix: --min-snp
  - id: plp_files
    type:
      type: array
      items: File
    doc: "Pileup files (<prefix>.plp.gz, .var.gz, .cel.gz, .umi.gz) written by dsc-pileup; staged in the working directory so that the plp prefix resolves"
outputs:
  - id: results
    type:
      type: array
      items: File
    doc: "Output files: <out>.clust1.samples.gz, <out>.clust1.vcf.gz, <out>.lmix and others"
    outputBinding:
      glob: "$(inputs.out).*"
  - id: log
    type: stderr
    doc: "Log messages"
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.plp_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popscle:0.1--ha0d7e29_1
stdout: popscle_freemuxlet.out
stderr: popscle_freemuxlet.log
