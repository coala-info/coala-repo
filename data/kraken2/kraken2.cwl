cwlVersion: v1.2
class: CommandLineTool
baseCommand: kraken2
label: kraken2
doc: "Kraken 2 is a taxonomic classification system that assigns taxonomic labels
  to short DNA sequences, usually obtained through metagenomic studies.\n\nTool homepage:
  http://ccb.jhu.edu/software/kraken/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kraken2:2.17.1--pl5321h077b44d_0
stdout: kraken2.out
