cwlVersion: v1.2
class: CommandLineTool
baseCommand: fraggenescan
label: fraggenescan
doc: "FragGeneScan is a tool for predicting genes from short reads and incomplete
  genomes.\n\nTool homepage: https://sourceforge.net/projects/fraggenescan/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fraggenescan:1.32--h7b50bb2_1
stdout: fraggenescan.out
