cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rbt
  - bam-anonymize
label: rust-bio-tools_bam-anonymize
doc: "Tool to build artifical reads from real BAM files with identical properties\n\
  \nTool homepage: https://github.com/rust-bio/rust-bio-tools"
inputs:
  - id: bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: input_ref
    type: File
    doc: Input reference as fasta file
    inputBinding:
      position: 2
  - id: chr
    type: string
    doc: chromosome name
    inputBinding:
      position: 3
  - id: start
    type: int
    doc: 1-based start position
    inputBinding:
      position: 4
  - id: end
    type: int
    doc: 1-based exclusive end position
    inputBinding:
      position: 5
  - id: keep_only_pairs
    type:
      - 'null'
      - boolean
    doc: Only simulates reads whos mates are both in defined range.
    inputBinding:
      position: 106
      prefix: --keep-only-pairs
outputs:
  - id: output_bam
    type: File
    doc: Output BAM file with artificial reads
    outputBinding:
      glob: '*.out'
  - id: output_ref
    type: File
    doc: Output fasta file with artificial reference
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
