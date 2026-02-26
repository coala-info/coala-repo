cwlVersion: v1.2
class: CommandLineTool
baseCommand: ALNtoPSL
label: fastga_ALNtoPSL
doc: "Convert alignment file to PSL format.\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
inputs:
  - id: alignment_file
    type: File
    doc: Input alignment file (e.g., .1aln)
    inputBinding:
      position: 1
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 8
    inputBinding:
      position: 102
      prefix: -T
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_ALNtoPSL.out
