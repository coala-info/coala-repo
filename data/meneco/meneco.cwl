cwlVersion: v1.2
class: CommandLineTool
baseCommand: meneco
label: meneco
doc: "A tool for metabolic network expansion (Note: The provided help text contains
  only container runtime error messages and no usage information).\n\nTool homepage:
  http://bioasp.github.io/meneco/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meneco:1.5.2--py35_0
stdout: meneco.out
