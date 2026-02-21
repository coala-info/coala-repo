cwlVersion: v1.2
class: CommandLineTool
baseCommand: matam
label: matam
doc: "Reconstruction of phylogenetic marker genes from metagenomic data\n\nTool homepage:
  https://github.com/bonsai-team/matam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/matam:1.6.2--haf24da9_0
stdout: matam.out
