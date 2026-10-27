cwlVersion: v1.2
class: CommandLineTool
baseCommand: wham
label: wham
doc: "WHAM-BAM is a tool for detecting structural variants from soft-clipped reads
  (the wham command of the wham package). Calls are written to standard output as
  VCF.\n\nTool homepage: https://github.com/zeeev/wham"
inputs:
  - id: target_bam_files
    type:
      type: array
      items: File
    doc: comma separated list of target bam files
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    inputBinding:
      position: 1
      prefix: -t
      itemSeparator: ','
  - id: reference_fasta
    type: File
    doc: reference sequence reads were aligned to
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 1
      prefix: -f
  - id: background_bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: comma separated list of background bam files
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    inputBinding:
      position: 1
      prefix: -b
      itemSeparator: ','
  - id: genomic_region
    type:
      - 'null'
      - string
    doc: a genomic region in the format "seqid:start-end"
    inputBinding:
      position: 1
      prefix: -r
  - id: threads
    type:
      - 'null'
      - int
    doc: set the number of threads, otherwise max [all]
    inputBinding:
      position: 1
      prefix: -x
  - id: regions_to_score_bedfile
    type:
      - 'null'
      - File
    doc: a bedfile that defines regions to score
    inputBinding:
      position: 1
      prefix: -e
  - id: min_soft_clips_start
    type:
      - 'null'
      - int
    doc: minimum number of soft-clips supporting START [3]
    inputBinding:
      position: 1
      prefix: -m
  - id: min_avg_base_quality
    type:
      - 'null'
      - int
    doc: exclude soft-cliped sequences with average base quality below phred 
      scaled value (0-41) [20]
    inputBinding:
      position: 1
      prefix: -q
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: exclude soft-clipped reads with mapping quality below value [15]
    inputBinding:
      position: 1
      prefix: -p
  - id: illumina_phred64
    type:
      - 'null'
      - boolean
    doc: base quality is Illumina 1.3+ Phred+64
    inputBinding:
      position: 1
      prefix: -i
outputs:
  - id: stdout
    type: stdout
    doc: Structural variant calls in VCF format
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wham:1.8.0.1.2017.05.03--hd28b015_0
stdout: wham.vcf
