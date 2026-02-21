cwlVersion: v1.2
class: CommandLineTool
baseCommand: gneiss
label: gneiss
doc: "A tool for analyzing composition data (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://biocore.github.io/gneiss/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gneiss:0.4.6--py_0
stdout: gneiss.out
