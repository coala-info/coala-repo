cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - fq-count
label: fuc_fq-count
doc: "Count sequence reads in FASTQ files.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: fastq
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTQ files (compressed or uncompressed)
    default: stdin
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_fq-count.out
