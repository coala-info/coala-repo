cwlVersion: v1.2
class: CommandLineTool
baseCommand: popscle_dsc-dump
label: popscle_dsc-dump
doc: "Produce a file dump of dsc-RNAseq\n\nTool homepage: https://github.com/statgen/popscle"
inputs:
  - id: cap_bq
    type:
      - 'null'
      - int
    doc: Maximum base quality (higher BQ will be capped)
    inputBinding:
      position: 101
      prefix: --cap-BQ
  - id: chunks
    type:
      - 'null'
      - int
    doc: Number of chunks to store barcodes randomly
    inputBinding:
      position: 101
      prefix: --chunks
  - id: excl_flag
    type:
      - 'null'
      - int
    doc: SAM/BAM FLAGs to be excluded
    inputBinding:
      position: 101
      prefix: --excl-flag
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
  - id: min_td
    type:
      - 'null'
      - int
    doc: Minimum distance to the tail (lower will be ignored)
    inputBinding:
      position: 101
      prefix: --min-TD
  - id: region
    type:
      - 'null'
      - string
    doc: Region to be focused on
    inputBinding:
      position: 101
      prefix: --region
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
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for random number generator
    inputBinding:
      position: 101
      prefix: --seed
  - id: skip_empty_group
    type:
      - 'null'
      - boolean
    doc: Skip read that does not have group (e.g. cell barcode) information. By 
      default it assigns barcode '.'
    inputBinding:
      position: 101
      prefix: --skip-empty-group
  - id: skip_empty_umi
    type:
      - 'null'
      - boolean
    doc: Skip read that does not have UMI (e.g. cell barcode) information. By 
      default it assigns all reads as a single UMI. To consider them all 
      independent reads, you need to set --tag-UMI '' (empty)
    inputBinding:
      position: 101
      prefix: --skip-empty-umi
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
