cwlVersion: v1.2
class: CommandLineTool
baseCommand: popscle_dsc-pileup
label: popscle_dsc-pileup
doc: "Produce pileup of dsc-RNAseq\n\nTool homepage: https://github.com/statgen/popscle"
inputs:
  - id: cap_bq
    type:
      - 'null'
      - int
    doc: Maximum base quality (higher BQ will be capped)
    inputBinding:
      position: 101
      prefix: --cap-BQ
  - id: excl_flag
    type:
      - 'null'
      - int
    doc: SAM/BAM FLAGs to be excluded
    inputBinding:
      position: 101
      prefix: --excl-flag
  - id: exclude_flag
    type:
      - 'null'
      - int
    doc: SAM/BAM flag to exclude
    inputBinding:
      position: 101
      prefix: --exclude-flag
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
    inputBinding:
      position: 101
      prefix: --min-BQ
  - id: min_mq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality to consider (lower MQ will be ignored)
    inputBinding:
      position: 101
      prefix: --min-MQ
  - id: min_snp
    type:
      - 'null'
      - int
    doc: Minimum number of SNPs with coverage for a droplet/cell to be 
      considered
    inputBinding:
      position: 101
      prefix: --min-snp
  - id: min_td
    type:
      - 'null'
      - int
    doc: Minimum distance to the tail (lower will be ignored)
    inputBinding:
      position: 101
      prefix: --min-TD
  - id: min_total
    type:
      - 'null'
      - int
    doc: Minimum number of total reads for a droplet/cell to be considered
    inputBinding:
      position: 101
      prefix: --min-total
  - id: min_uniq
    type:
      - 'null'
      - int
    doc: Minimum number of unique reads (determined by UMI/SNP pair) for a 
      droplet/cell to be considered
    inputBinding:
      position: 101
      prefix: --min-uniq
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
    inputBinding:
      position: 101
      prefix: --sam-verbose
  - id: skip_umi
    type:
      - 'null'
      - boolean
    doc: Do not generate [prefix].umi.gz file, which stores the regions covered 
      by each barcode/UMI pair
    inputBinding:
      position: 101
      prefix: --skip-umi
  - id: sm
    type:
      - 'null'
      - string
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
    inputBinding:
      position: 101
      prefix: --tag-group
  - id: tag_umi
    type:
      - 'null'
      - string
    doc: Tag representing UMIs. For 10x genomiucs, use UB
    inputBinding:
      position: 101
      prefix: --tag-UMI
  - id: vcf
    type:
      - 'null'
      - File
    doc: Input VCF/BCF file, containing the AC and AN field
    inputBinding:
      position: 101
      prefix: --vcf
  - id: vcf_verbose
    type:
      - 'null'
      - int
    doc: Verbose message frequency for VCF/BCF
    inputBinding:
      position: 101
      prefix: --vcf-verbose
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output file prefix
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popscle:0.1--ha0d7e29_1
