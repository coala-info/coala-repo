cwlVersion: v1.2
class: CommandLineTool
baseCommand: deacon
label: deacon
doc: "DEACON (DEconvolution of Amplicons with CONsensus) - A tool for processing amplicon
  sequencing data.\n\nTool homepage: https://github.com/bede/deacon"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deacon:0.13.2--h7ef3eeb_1
stdout: deacon.out
