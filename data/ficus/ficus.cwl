cwlVersion: v1.2
class: CommandLineTool
baseCommand: ficus
label: ficus
doc: "The provided text does not contain help information or a description of the
  tool's functionality. It contains system log messages and a fatal error regarding
  container image conversion and disk space.\n\nTool homepage: https://github.com/camillescott/ficus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ficus:0.5--py_1
stdout: ficus.out
