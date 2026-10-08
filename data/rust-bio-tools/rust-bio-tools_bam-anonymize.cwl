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
    secondaryFiles:
      - .bai
    doc: Input BAM file (indexed)
    inputBinding:
      position: 1
  - id: input_ref
    type: File
    secondaryFiles:
      - .fai
    doc: Input reference as fasta file (indexed)
    inputBinding:
      position: 2
  - id: output_bam
    type: string
    doc: Output BAM file with artificial reads
    inputBinding:
      position: 3
  - id: output_ref
    type: string
    doc: Output fasta file with artificial reference
    inputBinding:
      position: 4
  - id: chr
    type: string
    doc: chromosome name
    inputBinding:
      position: 5
  - id: start
    type: int
    doc: 1-based start position
    inputBinding:
      position: 6
  - id: end
    type: int
    doc: 1-based exclusive end position
    inputBinding:
      position: 7
  - id: keep_only_pairs
    type:
      - 'null'
      - boolean
    doc: Only simulates reads whos mates are both in defined range.
    inputBinding:
      position: 106
      prefix: --keep-only-pairs
outputs:
  - id: output_bam_file
    type: File
    doc: Output BAM file with artificial reads
    outputBinding:
      glob: $(inputs.output_bam)
  - id: output_ref_file
    type: File
    doc: Output fasta file with artificial reference
    outputBinding:
      glob: $(inputs.output_ref)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
