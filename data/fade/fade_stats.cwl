cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ./fade
  - stats
label: fade_stats
doc: "reports extended information about all artifact reads (used after annotate)\n\
  \nTool homepage: https://github.com/blachlylab/fade"
inputs:
  - id: annotated_bam_sam
    type: File
    doc: Input annotated BAM/SAM file
    inputBinding:
      position: 1
  - id: threads
    type:
      - 'null'
      - int
    doc: threads for parsing the bam file
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fade:0.6.0--h9ee0642_0
stdout: fade_stats.out
