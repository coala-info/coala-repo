cwlVersion: v1.2
class: CommandLineTool
baseCommand: metamaps
label: metamaps_mapagainstindex
doc: "Simultaneous metagenomic classification and mapping.\n\nTool homepage: https://github.com/DiltheyLab/MetaMaps"
inputs:
  - id: command
    type: string
    doc: 'Subcommand to run: mapDirectly, classify, mapAgainstIndex, or index'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metamaps:0.1.98102e9--h21ec9f0_2
stdout: metamaps_mapagainstindex.out
