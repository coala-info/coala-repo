cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfastx_index
label: pyfastx_index
doc: "Build index for fasta or fastq files\n\nTool homepage: https://github.com/lmdu/pyfastx"
inputs:
  - id: fastx_files
    type:
      type: array
      items: File
    doc: fasta or fastq file, gzip support
    inputBinding:
      position: 1
  - id: full_index
    type:
      - 'null'
      - boolean
    doc: build full index, base composition will be calculated
    inputBinding:
      position: 102
      prefix: --full
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastx:2.3.0--py312h4711d71_1
stdout: pyfastx_index.out
