cwlVersion: v1.2
class: CommandLineTool
baseCommand: popscle_demuxlet
label: popscle_demuxlet
doc: "Deconvolute sample identify of droplet-based sc-RNAseq\n\nTool homepage: https://github.com/statgen/popscle"
inputs:
  - id: alpha
    type:
      - 'null'
      - type: array
        items: float
    doc: Grid of alpha to search for (default is 0.1, 0.2, 0.3, 0.4, 0.5)
    default:
      - 0.1
      - 0.2
      - 0.3
      - 0.4
      - 0.5
    inputBinding:
      position: 101
      prefix: --alpha
  - id: cap_bq
    type:
      - 'null'
      - int
    doc: Maximum base quality (higher BQ will be capped)
    default: 20
    inputBinding:
      position: 101
      prefix: --cap-BQ
  - id: doublet_prior
    type:
      - 'null'
      - float
    doc: Prior of doublet
    default: 0.5
    inputBinding:
      position: 101
      prefix: --doublet-prior
  - id: excl_flag
    type:
      - 'null'
      - int
    doc: SAM/BAM FLAGs to be excluded
    default: 3844
    inputBinding:
      position: 101
      prefix: --excl-flag
  - id: field
    type:
      - 'null'
      - string
    doc: FORMAT field to extract the genotype, likelihood, or posterior from
    default: GP
    inputBinding:
      position: 101
      prefix: --field
  - id: geno_error_coeff
    type:
      - 'null'
      - float
    doc: Slope of genotype error rate. [error] = [offset] + 
      [1-offset]*[coeff]*[1-r2]
    default: 0.0
    inputBinding:
      position: 101
      prefix: --geno-error-coeff
  - id: geno_error_offset
    type:
      - 'null'
      - float
    doc: Offset of genotype error rate. [error] = [offset] + 
      [1-offset]*[coeff]*[1-r2]
    default: 0.1
    inputBinding:
      position: 101
      prefix: --geno-error-offset
  - id: group_list
    type:
      - 'null'
      - File
    doc: List of tag readgroup/cell barcode to consider in this run. All other 
      barcodes will be ignored. This is useful for parallelized run
    inputBinding:
      position: 101
      prefix: --group-list
  - id: min_bq
    type:
      - 'null'
      - int
    doc: Minimum base quality to consider (lower BQ will be skipped)
    default: 13
    inputBinding:
      position: 101
      prefix: --min-BQ
  - id: min_callrate
    type:
      - 'null'
      - float
    doc: Minimum call rate
    default: 0.5
    inputBinding:
      position: 101
      prefix: --min-callrate
  - id: min_mac
    type:
      - 'null'
      - int
    doc: Minimum minor allele frequency
    default: 1
    inputBinding:
      position: 101
      prefix: --min-mac
  - id: min_mq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality to consider (lower MQ will be ignored)
    default: 20
    inputBinding:
      position: 101
      prefix: --min-MQ
  - id: min_snp
    type:
      - 'null'
      - int
    doc: Minimum number of SNPs with coverage for a droplet/cell to be 
      considered
    default: 0
    inputBinding:
      position: 101
      prefix: --min-snp
  - id: min_td
    type:
      - 'null'
      - int
    doc: Minimum distance to the tail (lower will be ignored)
    default: 0
    inputBinding:
      position: 101
      prefix: --min-TD
  - id: min_total
    type:
      - 'null'
      - int
    doc: Minimum number of total reads for a droplet/cell to be considered
    default: 0
    inputBinding:
      position: 101
      prefix: --min-total
  - id: min_umi
    type:
      - 'null'
      - int
    doc: Minimum number of UMIs for a droplet/cell to be considered
    default: 0
    inputBinding:
      position: 101
      prefix: --min-umi
  - id: out
    type:
      - 'null'
      - string
    doc: Output file prefix
    inputBinding:
      position: 101
      prefix: --out
  - id: plp
    type:
      - 'null'
      - File
    doc: Input pileup format
    inputBinding:
      position: 101
      prefix: --plp
  - id: r2_info
    type:
      - 'null'
      - string
    doc: INFO field name representing R2 value. Used for representing imputation
      quality
    default: R2
    inputBinding:
      position: 101
      prefix: --r2-info
  - id: sam
    type:
      - 'null'
      - File
    doc: Input SAM/BAM/CRAM file. Must be sorted by coordinates and indexed
    inputBinding:
      position: 101
      prefix: --sam
  - id: sam_verbose
    type:
      - 'null'
      - int
    doc: Verbose message frequency for SAM/BAM/CRAM
    default: 1000000
    inputBinding:
      position: 101
      prefix: --sam-verbose
  - id: sm
    type:
      - 'null'
      - type: array
        items: string
    doc: 'List of sample IDs to compare to (default: use all)'
    inputBinding:
      position: 101
      prefix: --sm
  - id: sm_list
    type:
      - 'null'
      - File
    doc: File containing the list of sample IDs to compare
    inputBinding:
      position: 101
      prefix: --sm-list
  - id: tag_group
    type:
      - 'null'
      - string
    doc: Tag representing readgroup or cell barcodes, in the case to partition 
      the BAM file into multiple groups. For 10x genomics, use CB
    default: CB
    inputBinding:
      position: 101
      prefix: --tag-group
  - id: tag_umi
    type:
      - 'null'
      - string
    doc: Tag representing UMIs. For 10x genomiucs, use UB
    default: UB
    inputBinding:
      position: 101
      prefix: --tag-UMI
  - id: vcf
    type:
      - 'null'
      - File
    doc: Input VCF/BCF file, containing the individual genotypes (GT), posterior
      probability (GP), or genotype likelihood (PL)
    inputBinding:
      position: 101
      prefix: --vcf
  - id: vcf_verbose
    type:
      - 'null'
      - int
    doc: Verbose message frequency for VCF/BCF
    default: 10000
    inputBinding:
      position: 101
      prefix: --vcf-verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popscle:0.1--ha0d7e29_1
stdout: popscle_demuxlet.out
