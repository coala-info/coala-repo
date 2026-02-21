cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepsvr
label: deepsvr
doc: "Deep learning-based somatic variant refinement tool.\n\nTool homepage: https://github.com/griffithlab/deepsvr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepsvr:0.1.0--py_0
stdout: deepsvr.out
