cwlVersion: v1.2
class: CommandLineTool
baseCommand: PlasFlow.py
label: plasflow
doc: "PlasFlow is a set of scripts used for prediction of plasmid sequences in metagenomic
  contigs. It relies on neural network models trained on full genomes and plasmids
  sequences.\n\nTool homepage: https://github.com/smaegol/PlasFlow"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasflow:1.1.0--py35_0
stdout: plasflow.out
