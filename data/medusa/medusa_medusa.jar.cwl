cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - medusa.jar
label: medusa_medusa.jar
doc: "Medusa is a draft genome scaffolder that uses multiple reference genomes to
  organize the contigs of a draft genome.\n\nTool homepage: https://github.com/combogenomics/medusa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/medusa:1.6--1
stdout: medusa_medusa.jar.out
