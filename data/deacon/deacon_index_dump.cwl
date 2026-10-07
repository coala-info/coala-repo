cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deacon
  - index
  - dump
label: deacon_index_dump
doc: "Dump minimizer index to fasta\n\nTool homepage: https://github.com/bede/deacon"
inputs:
  - id: index
    type: File
    doc: Path to index file
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: Path to output FASTA file
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: fasta
    type: File
    doc: FASTA file with one record per minimizer
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deacon:0.13.2--h7ef3eeb_1
