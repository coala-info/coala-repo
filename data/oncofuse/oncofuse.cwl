cwlVersion: v1.2
class: CommandLineTool
baseCommand: oncofuse
label: oncofuse
doc: "Oncofuse is a tool designed to predict the oncogenic potential of gene fusions
  found in cancer cell genomes.\n\nTool homepage: https://github.com/mikessh/oncofuse"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oncofuse:1.1.1--1
stdout: oncofuse.out
