cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam-somaticsniper
label: somatic-sniper
doc: "SomaticSniper identifies single nucleotide variants (SNVs) by comparing tumor
  and normal BAM files.\n\nTool homepage: https://github.com/uclahs-cds/docker-SomaticSniper"
inputs:
  - id: tumor_bam
    type: File
    doc: Tumor BAM file
    inputBinding:
      position: 1
  - id: normal_bam
    type: File
    doc: Normal BAM file
    inputBinding:
      position: 2
  - id: haploid_mode
    type:
      - 'null'
      - boolean
    doc: Disable priors in the somatic calculation
    inputBinding:
      position: 103
      prefix: -p
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality
    inputBinding:
      position: 103
      prefix: -L
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: 'Filtering priority: minimum mapping quality'
    default: 0
    inputBinding:
      position: 103
      prefix: -q
  - id: min_somatic_score
    type:
      - 'null'
      - int
    doc: Minimum somatic score
    default: 15
    inputBinding:
      position: 103
      prefix: -Q
  - id: out_format
    type:
      - 'null'
      - string
    doc: Output format (classic, vcf, bed)
    inputBinding:
      position: 103
      prefix: -F
  - id: prior_probability
    type:
      - 'null'
      - float
    doc: Prior probability of a somatic mutation
    default: 0.01
    inputBinding:
      position: 103
      prefix: -s
  - id: reference_fasta
    type: File
    doc: Reference fasta
    inputBinding:
      position: 103
      prefix: -f
  - id: theta
    type:
      - 'null'
      - float
    doc: Theta in the somatic calculation
    default: 0.85
    inputBinding:
      position: 103
      prefix: -T
  - id: use_jq_format
    type:
      - 'null'
      - boolean
    doc: Use JQ format for output
    inputBinding:
      position: 103
      prefix: -J
outputs:
  - id: output_file
    type: File
    doc: Output file for somatic SNVs
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/somatic-sniper:1.0.5.0--0
