cwlVersion: v1.2
class: CommandLineTool
baseCommand: [popscle, demuxlet]
label: popscle_demuxlet
doc: "Deconvolute sample identity of droplet-based single-cell RNA-seq (sample genotypes known).\n\nTool homepage: https://github.com/statgen/popscle"
inputs:
  - id: sam
    type:
      - 'null'
      - File
    secondaryFiles:
      - ".bai"
    doc: "Input SAM/BAM/CRAM file. Must be sorted by coordinates and indexed"
    inputBinding:
      position: 1
      prefix: --sam
  - id: tag_group
    type:
      - 'null'
      - string
    doc: "Tag representing readgroup or cell barcodes, in the case to partition the BAM file into multiple groups. For 10x genomics, use CB Default: CB"
    inputBinding:
      position: 1
      prefix: --tag-group
  - id: tag_umi
    type:
      - 'null'
      - string
    doc: "Tag representing UMIs. For 10x genomiucs, use UB Default: UB"
    inputBinding:
      position: 1
      prefix: --tag-UMI
  - id: plp
    type:
      - 'null'
      - string
    doc: "Prefix of the input pileup files (<prefix>.plp.gz, .var.gz, .cel.gz, .umi.gz)"
    inputBinding:
      position: 1
      prefix: --plp
  - id: vcf
    type:
      - 'null'
      - File
    doc: "Input VCF/BCF file, containing the individual genotypes (GT), posterior probability (GP), or genotype likelihood (PL)"
    inputBinding:
      position: 1
      prefix: --vcf
  - id: field
    type:
      - 'null'
      - string
    doc: "FORMAT field to extract the genotype, likelihood, or posterior from Default: GP"
    inputBinding:
      position: 1
      prefix: --field
  - id: geno_error_offset
    type:
      - 'null'
      - float
    doc: "Offset of genotype error rate. [error] = [offset] + [1-offset]*[coeff]*[1-r2] Default: 0.10"
    inputBinding:
      position: 1
      prefix: --geno-error-offset
  - id: geno_error_coeff
    type:
      - 'null'
      - float
    doc: "Slope of genotype error rate. [error] = [offset] + [1-offset]*[coeff]*[1-r2] Default: 0.00"
    inputBinding:
      position: 1
      prefix: --geno-error-coeff
  - id: r2_info
    type:
      - 'null'
      - string
    doc: "INFO field name representing R2 value. Used for representing imputation quality Default: R2"
    inputBinding:
      position: 1
      prefix: --r2-info
  - id: min_mac
    type:
      - 'null'
      - int
    doc: "Minimum minor allele frequency Default: 1"
    inputBinding:
      position: 1
      prefix: --min-mac
  - id: min_callrate
    type:
      - 'null'
      - float
    doc: "Minimum call rate Default: 0.50"
    inputBinding:
      position: 1
      prefix: --min-callrate
  - id: sm
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --sm
    doc: "List of sample IDs to compare to (default: use all) (repeat the option for several values)"
    inputBinding:
      position: 1
  - id: sm_list
    type:
      - 'null'
      - File
    doc: "File containing the list of sample IDs to compare"
    inputBinding:
      position: 1
      prefix: --sm-list
  - id: out
    type: string
    doc: "Output file prefix"
    inputBinding:
      position: 1
      prefix: --out
  - id: alpha
    type:
      - 'null'
      - type: array
        items: float
        inputBinding:
          prefix: --alpha
    doc: "Grid of alpha to search for (default is 0.1, 0.2, 0.3, 0.4, 0.5) (repeat the option for several values)"
    inputBinding:
      position: 1
  - id: doublet_prior
    type:
      - 'null'
      - float
    doc: "Prior of doublet Default: 0.50"
    inputBinding:
      position: 1
      prefix: --doublet-prior
  - id: sam_verbose
    type:
      - 'null'
      - int
    doc: "Verbose message frequency for SAM/BAM/CRAM Default: 1000000"
    inputBinding:
      position: 1
      prefix: --sam-verbose
  - id: vcf_verbose
    type:
      - 'null'
      - int
    doc: "Verbose message frequency for VCF/BCF Default: 10000"
    inputBinding:
      position: 1
      prefix: --vcf-verbose
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
  - id: min_mq
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality to consider (lower MQ will be ignored) Default: 20"
    inputBinding:
      position: 1
      prefix: --min-MQ
  - id: min_td
    type:
      - 'null'
      - int
    doc: "Minimum distance to the tail (lower will be ignored) Default: 0"
    inputBinding:
      position: 1
      prefix: --min-TD
  - id: excl_flag
    type:
      - 'null'
      - int
    doc: "SAM/BAM FLAGs to be excluded Default: 3844"
    inputBinding:
      position: 1
      prefix: --excl-flag
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
      - 'null'
      - type: array
        items: File
    doc: "Pileup files (<prefix>.plp.gz, .var.gz, .cel.gz, .umi.gz) for use with plp; staged in the working directory so that the prefix resolves"
outputs:
  - id: results
    type:
      type: array
      items: File
    doc: "Output files (<out>.best and others)"
    outputBinding:
      glob: "$(inputs.out).*"
  - id: log
    type: stderr
    doc: "Log messages"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.plp_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popscle:0.1--ha0d7e29_1
stdout: popscle_demuxlet.out
stderr: popscle_demuxlet.log
