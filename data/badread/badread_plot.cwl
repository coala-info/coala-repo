cwlVersion: v1.2
class: CommandLineTool
baseCommand: badread_plot
label: badread_plot
doc: "View read identities over a sliding window\n\nTool homepage: https://github.com/rrwick/Badread"
inputs:
  - id: alignment
    type: File
    doc: PAF alignment of reads aligned to reference
    inputBinding:
      position: 101
      prefix: --alignment
  - id: no_plot
    type:
      - 'null'
      - boolean
    doc: Do not display plots (for testing purposes)
    inputBinding:
      position: 101
      prefix: --no_plot
  - id: qual
    type:
      - 'null'
      - boolean
    doc: 'Include qscores in plot (default: only show identity)'
    inputBinding:
      position: 101
      prefix: --qual
  - id: reads
    type: File
    doc: FASTQ of real reads
    inputBinding:
      position: 101
      prefix: --reads
  - id: reference
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 101
      prefix: --reference
  - id: window
    type:
      - 'null'
      - int
    doc: Window size in bp
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/badread:0.4.1--pyhdfd78af_0
stdout: badread_plot.out
