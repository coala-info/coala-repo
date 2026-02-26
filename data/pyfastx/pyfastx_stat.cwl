cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfastx_stat
label: pyfastx_stat
doc: "Show statistics for fasta or fastq files.\n\nTool homepage: https://github.com/lmdu/pyfastx"
inputs:
  - id: fastx
    type:
      type: array
      items: File
    doc: fasta or fastq file, gzip support
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastx:2.3.0--py312h4711d71_1
stdout: pyfastx_stat.out
