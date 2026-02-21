cwlVersion: v1.2
class: CommandLineTool
baseCommand: doubletd
label: doubletd
doc: "A tool for doublet detection (Note: The provided text contains only container
  runtime error messages and no help documentation. No arguments could be extracted.)\n
  \nTool homepage: https://github.com/elkebir-group/doubletD"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/doubletd:0.1.0--py_0
stdout: doubletd.out
