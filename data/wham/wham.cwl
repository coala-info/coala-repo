cwlVersion: v1.2
class: CommandLineTool
baseCommand: WHAM-BAM
label: wham
doc: "WHAM-BAM is a tool for detecting structural variants.\n\nTool homepage: https://github.com/zeeev/wham"
inputs:
  - id: background_bam_files
    type:
      - 'null'
      - type: array
        items: string
    doc: comma separated list of background bam files
    inputBinding:
      position: 101
      prefix: --background_bam_files
  - id: genomic_region
    type:
      - 'null'
      - string
    doc: a genomic region in the format "seqid:start-end"
    inputBinding:
      position: 101
      prefix: --genomic_region
  - id: illumina_phred64
    type:
      - 'null'
      - boolean
    doc: base quality is Illumina 1.3+ Phred+64
    inputBinding:
      position: 101
      prefix: --illumina_phred64
  - id: min_avg_base_quality
    type:
      - 'null'
      - int
    doc: exclude soft-cliped sequences with average base quality below phred 
      scaled value (0-41)
    inputBinding:
      position: 101
      prefix: --min_avg_base_quality
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: exclude soft-clipped reads with mapping quality below value
    inputBinding:
      position: 101
      prefix: --min_mapping_quality
  - id: min_soft_clips_start
    type:
      - 'null'
      - int
    doc: minimum number of soft-clips supporting START
    inputBinding:
      position: 101
      prefix: --min_soft_clips_start
  - id: reference_fasta
    type: string
    doc: reference sequence reads were aligned to
    inputBinding:
      position: 101
      prefix: --reference_fasta
  - id: regions_to_score_bedfile
    type:
      - 'null'
      - File
    doc: a bedfile that defines regions to score
    inputBinding:
      position: 101
      prefix: --regions_to_score_bedfile
  - id: target_bam_files
    type:
      type: array
      items: string
    doc: comma separated list of target bam files
    inputBinding:
      position: 101
      prefix: --target_bam_files
  - id: threads
    type:
      - 'null'
      - int
    doc: set the number of threads, otherwise max [all]
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wham:1.8.0.1.2017.05.03--hd28b015_0
stdout: wham.out
