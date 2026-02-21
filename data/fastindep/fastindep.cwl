cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastindep
label: fastindep
doc: "FastIndep is a tool for identifying independent sets of individuals in large-scale
  genetic data.\n\nTool homepage: https://github.com/endrebak/fastindep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastindep:1.0.0--h9f5acd7_4
stdout: fastindep.out
