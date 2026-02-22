cwlVersion: v1.2
class: CommandLineTool
baseCommand: pafpy
label: pafpy
doc: "A tool for working with Pairwise mApping Format (PAF) files.\n\nTool homepage:
  https://github.com/mbhall88/pafpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pafpy:0.2.0--py_0
stdout: pafpy.out
