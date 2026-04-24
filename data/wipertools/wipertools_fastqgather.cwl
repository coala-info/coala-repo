cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wipertools
  - fastqgather
label: wipertools_fastqgather
doc: "Joins multiple FASTQ files into a single one.\n\nTool homepage: https://github.com/mazzalab/fastqwiper"
inputs:
  - id: in_fastq
    type:
      type: array
      items: File
    doc: List of FASTQ files to be joined
    inputBinding:
      position: 1
  - id: os
    type:
      - 'null'
      - string
    doc: Underlying OS
    inputBinding:
      position: 102
      prefix: --os
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix common to the files to be joined
    inputBinding:
      position: 102
      prefix: --prefix
outputs:
  - id: out_fastq
    type: File
    doc: Name of the resulting fastq file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wipertools:1.1.5--pyhdfd78af_0
