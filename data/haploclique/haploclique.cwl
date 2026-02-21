cwlVersion: v1.2
class: CommandLineTool
baseCommand: haploclique
label: haploclique
doc: "A tool for viral haplotype reconstruction from next-generation sequencing data.\n
  \nTool homepage: https://github.com/cbg-ethz/haploclique"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haploclique:1.3.1--h2b6358e_4
stdout: haploclique.out
