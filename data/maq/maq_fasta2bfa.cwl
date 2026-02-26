cwlVersion: v1.2
class: CommandLineTool
baseCommand: maq fasta2bfa
label: maq_fasta2bfa
doc: "\nTool homepage: https://github.com/maqetta/maqetta"
inputs:
  - id: in_fasta
    type: File
    inputBinding:
      position: 1
outputs:
  - id: out_bfa
    type: File
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
