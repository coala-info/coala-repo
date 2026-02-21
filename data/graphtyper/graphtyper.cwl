cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphtyper
label: graphtyper
doc: "A graph-based variant caller for next-generation sequencing data.\n\nTool homepage:
  https://github.com/DecodeGenetics/graphtyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
stdout: graphtyper.out
