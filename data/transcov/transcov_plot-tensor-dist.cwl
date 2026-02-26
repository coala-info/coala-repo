cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transcov
  - plot-tensor-dist
label: transcov_plot-tensor-dist
doc: "Plot distance distribution for tensors.\n\nTool homepage: https://github.com/hogfeldt/transcov"
inputs:
  - id: input_tensor
    type: File
    doc: Input tensor file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transcov:1.1.3--py_0
stdout: transcov_plot-tensor-dist.out
