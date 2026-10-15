cwlVersion: v1.2
class: CommandLineTool
baseCommand: [popscle, dsc-dump]
label: popscle_dsc-dump
doc: "Produce a file dump of droplet-based single-cell RNA-seq reads overlapping the SNPs of a VCF.\n\nTool homepage: https://github.com/statgen/popscle"
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
  - id: region
    type:
      - 'null'
      - string
    doc: "Region to be focused on"
    inputBinding:
      position: 1
      prefix: --region
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
  - id: excl_flag
    type:
      - 'null'
      - int
    doc: "SAM/BAM FLAGs to be excluded Default: 3844"
    inputBinding:
      position: 1
      prefix: --excl-flag
  - id: vcf
    type:
      - 'null'
      - File
    doc: "Input VCF/BCF file, containing the AC and AN field"
    inputBinding:
      position: 1
      prefix: --vcf
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
  - id: skip_umi
    type:
      - 'null'
      - boolean
    doc: "Do not generate [prefix].umi.gz file, which stores the regions covered by each barcode/UMI pair Default: OFF"
    inputBinding:
      position: 1
      prefix: --skip-umi
  - id: skip_empty_group
    type:
      - 'null'
      - boolean
    doc: "Skip read that does not have group (e.g. cell barcode) information. By default it assigns barcode '.' Default: OFF"
    inputBinding:
      position: 1
      prefix: --skip-empty-group
  - id: skip_empty_umi
    type:
      - 'null'
      - boolean
    doc: "Skip read that does not have UMI (e.g. cell barcode) information. By default it assigns all reads as a single UMI. To consider them all independent reads, you need to set --tag-UMI '' (empty) Default: OFF"
    inputBinding:
      position: 1
      prefix: --skip-empty-umi
  - id: chunks
    type:
      - 'null'
      - int
    doc: "Number of chunks to store barcodes randomly Default: 100"
    inputBinding:
      position: 1
      prefix: --chunks
  - id: seed
    type:
      - 'null'
      - int
    doc: "Seed for random number generator Default: -2128831035"
    inputBinding:
      position: 1
      prefix: --seed
  - id: cap_bq
    type:
      - 'null'
      - int
    doc: "Maximum base quality (higher BQ will be capped) Default: 40"
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
  - id: group_list
    type:
      - 'null'
      - File
    doc: "List of tag readgroup/cell barcode to consider in this run. All other barcodes will be ignored. This is useful for parallelized run"
    inputBinding:
      position: 1
      prefix: --group-list
outputs:
  - id: dump_files
    type:
      type: array
      items: File
    doc: "Dump files: <out>.barcodes.tsv.gz, <out>.variants.tsv.gz"
    outputBinding:
      glob: "$(inputs.out).*.gz"
  - id: dump_tmp
    type:
      - 'null'
      - Directory
    doc: "Chunk files <out>.tmp/chunk.*.tsv.gz"
    outputBinding:
      glob: "$(inputs.out).tmp"
  - id: log
    type: stderr
    doc: "Log messages"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popscle:0.1--ha0d7e29_1
stdout: popscle_dsc-dump.out
stderr: popscle_dsc-dump.log
