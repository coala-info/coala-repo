cwlVersion: v1.2
class: CommandLineTool
baseCommand: medusa
label: medusa
doc: "A draft genome scaffolder that uses multiple reference genomes to determine
  the correct order and orientation of contigs.\n\nTool homepage: https://github.com/combogenomics/medusa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/medusa:1.6--1
stdout: medusa.out
