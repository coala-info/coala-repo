cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamdst
label: bamdst
doc: "A lightweight tool to calculate depth and coverage statistics for target regions
  in BAM files.\n\nTool homepage: https://github.com/shiquan/bamdst"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: bed_file
    type: File
    doc: Target regions in BED format
    inputBinding:
      position: 102
      prefix: --bed
  - id: flank
    type:
      - 'null'
      - int
    doc: Flank distance
    default: 0
    inputBinding:
      position: 102
      prefix: -f
  - id: is_duplicate
    type:
      - 'null'
      - boolean
    doc: Include duplicate reads
    inputBinding:
      position: 102
      prefix: --is-duplicate
  - id: is_qcfail
    type:
      - 'null'
      - boolean
    doc: Include QC failed reads
    inputBinding:
      position: 102
      prefix: --is-qcfail
  - id: is_secondary
    type:
      - 'null'
      - boolean
    doc: Include secondary alignments
    inputBinding:
      position: 102
      prefix: --is-secondary
  - id: is_supplementary
    type:
      - 'null'
      - boolean
    doc: Include supplementary alignments
    inputBinding:
      position: 102
      prefix: --is-supplementary
  - id: max_len
    type:
      - 'null'
      - int
    doc: Maximum read length
    default: 20000
    inputBinding:
      position: 102
      prefix: --max-len
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    default: 0
    inputBinding:
      position: 102
      prefix: -q
  - id: uncover_cutoff
    type:
      - 'null'
      - int
    doc: Cutoff for uncovered regions
    default: 5
    inputBinding:
      position: 102
      prefix: --uncover-cutoff
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bamdst:1.0.9_cv1
