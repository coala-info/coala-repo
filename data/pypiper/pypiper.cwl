cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypiper
label: pypiper
doc: "A tool for pipeline management and execution.\n\nTool homepage: http://pypiper.readthedocs.io/en/latest/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypiper:0.8--py_0
stdout: pypiper.out
