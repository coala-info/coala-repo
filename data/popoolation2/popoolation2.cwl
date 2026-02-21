cwlVersion: v1.2
class: CommandLineTool
baseCommand: popoolation2
label: popoolation2
doc: "PoPoolation2 allows to compare allele frequencies for SNPs between two or more
  populations and to identify genomic regions showing significant differentiation.\n
  \nTool homepage: https://sourceforge.net/projects/popoolation2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popoolation2:1.201--pl5321hdfd78af_0
stdout: popoolation2.out
