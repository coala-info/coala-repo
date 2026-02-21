cwlVersion: v1.2
class: CommandLineTool
baseCommand: loomxpy
label: loomxpy
doc: "A Python package for creating and manipulating .loom files.\n\nTool homepage:
  https://github.com/aertslab/loomxpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/loomxpy:0.4.2--pyhdfd78af_0
stdout: loomxpy.out
