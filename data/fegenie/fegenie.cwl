cwlVersion: v1.2
class: CommandLineTool
baseCommand: fegenie
label: fegenie
doc: "FeGenie: a comprehensive tool for the identification of iron genes and gene
  clusters in genomes and metagenomes.\n\nTool homepage: https://github.com/Arkadiy-Garber/FeGenie"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fegenie:1.2--py313r40hdfd78af_5
stdout: fegenie.out
