cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biscuit
  - bsstrand
label: biscuit_bsstrand
doc: "Correct or append bisulfite strand information in BAM files\n\nTool homepage:
  https://github.com/huishenlab/biscuit"
inputs:
  - id: reference_fasta
    type: File
    doc: Reference fasta file
    inputBinding:
      position: 1
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 2
  - id: append_counts
    type:
      - 'null'
      - boolean
    doc: Append count of C>T (YC tag) and G>A (YG tag) in out.bam
    inputBinding:
      position: 103
      prefix: -y
  - id: correct_bsstrand
    type:
      - 'null'
      - boolean
    doc: Correct bsstrand in out.bam, YD tag will be replaced if it exists and created
      if not
    inputBinding:
      position: 103
      prefix: -c
  - id: region
    type:
      - 'null'
      - string
    doc: Region (optional, will process the whole bam if not specified)
    inputBinding:
      position: 103
      prefix: -g
outputs:
  - id: output_bam
    type:
      - 'null'
      - File
    doc: Output BAM file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biscuit:1.7.1.20250908--hc4b60c0_0
