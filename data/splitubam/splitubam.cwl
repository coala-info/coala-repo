cwlVersion: v1.2
class: CommandLineTool
baseCommand: splitubam
label: splitubam
doc: "Tool to split one ubam file into multiple\n\nTool homepage: https://github.com/fellen31/splitubam"
inputs:
  - id: input
    type: File
    doc: bam file to split
    inputBinding:
      position: 1
  - id: compression
    type:
      - 'null'
      - int
    doc: BAM output compression level
    inputBinding:
      position: 102
      prefix: --compression
  - id: split
    type: int
    doc: Number of files to split bam to
    inputBinding:
      position: 102
      prefix: --split
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel decompression & writer threads to use
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/splitubam:0.1.1--ha96b9cd_1
stdout: splitubam.out
