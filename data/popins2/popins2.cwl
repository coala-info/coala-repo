cwlVersion: v1.2
class: CommandLineTool
baseCommand: popins2
label: popins2
doc: "PopIns2 is a tool for discovering and characterizing non-reference insertions
  in next-generation sequencing data.\n\nTool homepage: https://github.com/kehrlab/PopIns2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popins2:0.13.0--h077b44d_0
stdout: popins2.out
