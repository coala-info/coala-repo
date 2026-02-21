cwlVersion: v1.2
class: CommandLineTool
baseCommand: expressbetadiversity
label: expressbetadiversity
doc: "A tool for calculating beta diversity (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://github.com/dparks1134/ExpressBetaDiversity"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expressbetadiversity:1.0.10--h9f5acd7_3
stdout: expressbetadiversity.out
