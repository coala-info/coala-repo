cwlVersion: v1.2
class: CommandLineTool
baseCommand: skder
label: skder
doc: "A tool for calculating genomic distances and Average Nucleotide Identity (ANI).\n
  \nTool homepage: https://github.com/raufs/skDER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skder:1.3.4--py310h184ae93_0
stdout: skder.out
