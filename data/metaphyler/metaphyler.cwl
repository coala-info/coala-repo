cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaphyler
label: metaphyler
doc: "MetaPhyler is a taxonomic classifier for metagenomic sequences. (Note: The provided
  text contains system error messages and does not list specific command-line arguments.)\n
  \nTool homepage: https://github.com/decaos/MetaPhyler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaphyler:1.25--h7b50bb2_8
stdout: metaphyler.out
