cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - haplogrep3
  - align
label: haplogrep3_align
doc: "Align a FASTA file to the reference of a phylotree.\n\nTool homepage: https://github.com/genepi/haplogrep3"
inputs:
  - id: fasta
    type: File
    doc: "input fasta file"
    inputBinding:
      position: 101
      prefix: --fasta
  - id: output
    type: string
    doc: "output aligned fasta file"
    inputBinding:
      position: 101
      prefix: --output
  - id: tree
    type: string
    doc: "Tree Id"
    inputBinding:
      position: 101
      prefix: --tree
outputs:
  - id: aligned_fasta
    type: File
    doc: "Aligned FASTA file"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplogrep3:3.2.2--hdfd78af_1
