cwlVersion: v1.2
class: CommandLineTool
baseCommand: metamaps
label: metamaps
doc: "Metamaps is a tool for metagenomic analysis, though the provided text contains
  only system error logs and no specific help documentation.\n\nTool homepage: https://github.com/DiltheyLab/MetaMaps"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metamaps:0.1.98102e9--h21ec9f0_2
stdout: metamaps.out
