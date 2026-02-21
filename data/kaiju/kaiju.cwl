cwlVersion: v1.2
class: CommandLineTool
baseCommand: kaiju
label: kaiju
doc: "Kaiju is a program for sensitive taxonomic classification of high-throughput
  sequencing reads from metagenomic whole genome sequencing or metatranscriptomics
  experiments.\n\nTool homepage: https://kaiju.binf.ku.dk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
stdout: kaiju.out
