cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biscuit
  - tview
label: biscuit_tview
doc: "Text-based alignment viewer for BISCUIT\n\nTool homepage: https://github.com/huishenlab/biscuit"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: reference_fasta
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 2
  - id: flanking_length
    type:
      - 'null'
      - int
    doc: Flanking sequence length
    inputBinding:
      position: 103
      prefix: -f
  - id: go_to_position
    type:
      - 'null'
      - string
    doc: Go directly to this position
    inputBinding:
      position: 103
      prefix: -g
  - id: highlight_read
    type:
      - 'null'
      - string
    doc: Highlight the read(s) with STR as the read name
    inputBinding:
      position: 103
      prefix: -n
  - id: max_reads
    type:
      - 'null'
      - int
    doc: Max number of reads to load per position
    inputBinding:
      position: 103
      prefix: -m
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biscuit:1.7.1.20250908--hc4b60c0_0
stdout: biscuit_tview.out
