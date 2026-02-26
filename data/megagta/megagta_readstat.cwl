cwlVersion: v1.2
class: CommandLineTool
baseCommand: readstat
label: megagta_readstat
doc: "Reads FASTQ files from standard input.\n\nTool homepage: https://github.com/HKU-BAL/MegaGTA"
inputs:
  - id: input_fastq
    type:
      type: array
      items: File
    doc: FASTQ files to read from standard input.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megagta:0.1_alpha--0
stdout: megagta_readstat.out
