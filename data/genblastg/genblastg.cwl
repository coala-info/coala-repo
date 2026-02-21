cwlVersion: v1.2
class: CommandLineTool
baseCommand: genblastg
label: genblastg
doc: "genBlastG is a tool for gene discovery using protein homology. Note: The provided
  help text contains only system error messages and no usage information.\n\nTool
  homepage: http://genome.sfu.ca/genblast/download.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genblastg:1.39--1
stdout: genblastg.out
