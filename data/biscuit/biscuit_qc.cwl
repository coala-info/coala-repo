cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biscuit
  - qc
label: biscuit_qc
doc: "Produces a subset of QC metrics for BISCUIT alignments.\n\nTool homepage: https://github.com/huishenlab/biscuit"
inputs:
  - id: reference_fasta
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 1
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 2
  - id: sample_name
    type: string
    doc: Name of the sample
    inputBinding:
      position: 3
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: Run for single-end data
    inputBinding:
      position: 104
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biscuit:1.7.1.20250908--hc4b60c0_0
stdout: biscuit_qc.out
