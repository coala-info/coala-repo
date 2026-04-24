cwlVersion: v1.2
class: CommandLineTool
baseCommand: owl_profile
label: owl_profile
doc: "Profile a BAM file\n\nTool homepage: https://github.com/PacificBiosciences/owl"
inputs:
  - id: bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 101
      prefix: --bam
  - id: flag
    type:
      - 'null'
      - int
    doc: Filter flag
    inputBinding:
      position: 101
      prefix: --flag
  - id: keep_lengths
    type:
      - 'null'
      - boolean
    doc: Keep motif spans in the output in the ln field
    inputBinding:
      position: 101
      prefix: --keep-lengths
  - id: max_filt_frac
    type:
      - 'null'
      - float
    doc: Max fraction of filtered reads
    inputBinding:
      position: 101
      prefix: --max-filt-frac
  - id: min_bq
    type:
      - 'null'
      - int
    doc: Min region avg base qual
    inputBinding:
      position: 101
      prefix: --min-bq
  - id: min_cov
    type:
      - 'null'
      - int
    doc: Min coverage
    inputBinding:
      position: 101
      prefix: --min-cov
  - id: min_idt
    type:
      - 'null'
      - int
    doc: Min motif alignment identity
    inputBinding:
      position: 101
      prefix: --min-idt
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Min mapQ
    inputBinding:
      position: 101
      prefix: --min-mapq
  - id: min_mg
    type:
      - 'null'
      - float
    doc: Min MG
    inputBinding:
      position: 101
      prefix: --min-mg
  - id: regions
    type: File
    doc: Genomic region(s) to score for MSI (bed format with motif)
    inputBinding:
      position: 101
      prefix: --regions
  - id: sample
    type:
      - 'null'
      - string
    doc: Sample name, SM bam tag is default
    inputBinding:
      position: 101
      prefix: --sample
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Verbosity
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/owl:0.4.0--h9ee0642_0
stdout: owl_profile.out
