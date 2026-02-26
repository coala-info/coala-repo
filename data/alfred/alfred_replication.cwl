cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alfred
  - replication
label: alfred_replication
doc: "Alfred replication analysis tool for analyzing replication timing using BAM
  files and a reference genome.\n\nTool homepage: https://github.com/tobiasrausch/alfred"
inputs:
  - id: g1_bam
    type: File
    doc: G1 phase BAM file
    inputBinding:
      position: 1
  - id: s_phase_bams
    type:
      type: array
      items: File
    doc: S phase BAM files (s1.bam, s2.bam, s3.bam, s4.bam)
    inputBinding:
      position: 2
  - id: g2_bam
    type: File
    doc: G2 phase BAM file
    inputBinding:
      position: 3
  - id: qual
    type:
      - 'null'
      - int
    doc: min. mapping quality
    default: 1
    inputBinding:
      position: 104
      prefix: --qual
  - id: reference
    type: File
    doc: reference fasta file (required)
    inputBinding:
      position: 104
      prefix: --reference
  - id: step
    type:
      - 'null'
      - int
    doc: window offset (step size)
    default: 1000
    inputBinding:
      position: 104
      prefix: --step
  - id: window
    type:
      - 'null'
      - int
    doc: sliding window size
    default: 50000
    inputBinding:
      position: 104
      prefix: --window
outputs:
  - id: outprefix
    type: File
    doc: output file prefix
    outputBinding:
      glob: $(inputs.outprefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
