cwlVersion: v1.2
class: CommandLineTool
baseCommand: medpy
label: medpy
doc: "Medical image processing library (Note: The provided text contains system error
  logs rather than tool help documentation).\n\nTool homepage: https://github.com/loli/medpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/medpy:0.4.0--py_0
stdout: medpy.out
