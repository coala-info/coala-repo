cwlVersion: v1.2
class: CommandLineTool
baseCommand: sambamba-flagstat
label: sambamba_flagstat
doc: "Outputs SAM/BAM/CRAM alignment statistics.\n\nTool homepage: https://github.com/biod/sambamba"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: nthreads
    type:
      - 'null'
      - int
    doc: use NTHREADS for decompression
    inputBinding:
      position: 102
      prefix: --nthreads
  - id: show_progress
    type:
      - 'null'
      - boolean
    doc: show progressbar in STDERR
    inputBinding:
      position: 102
      prefix: --show-progress
  - id: tabular
    type:
      - 'null'
      - boolean
    doc: output in csv format
    inputBinding:
      position: 102
      prefix: --tabular
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sambamba:1.0.1--he614052_4
stdout: sambamba_flagstat.out
