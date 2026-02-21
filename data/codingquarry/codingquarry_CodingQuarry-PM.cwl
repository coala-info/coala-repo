cwlVersion: v1.2
class: CommandLineTool
baseCommand: CodingQuarry-PM
label: codingquarry_CodingQuarry-PM
doc: "CodingQuarry-PM (Note: The provided help text contains only system error messages
  regarding container execution and does not list tool-specific arguments.)\n\nTool
  homepage: https://sourceforge.net/p/codingquarry/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/codingquarry:2.0--py311he264feb_11
stdout: codingquarry_CodingQuarry-PM.out
