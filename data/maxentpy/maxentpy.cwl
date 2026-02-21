cwlVersion: v1.2
class: CommandLineTool
baseCommand: maxentpy
label: maxentpy
doc: "A tool for scoring splice sites using Maximum Entropy Model (Note: The provided
  help text contains only system error messages and no usage information).\n\nTool
  homepage: https://github.com/kepbod/maxentpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maxentpy:0.02--py310h1425a21_1
stdout: maxentpy.out
