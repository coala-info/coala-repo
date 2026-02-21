cwlVersion: v1.2
class: CommandLineTool
baseCommand: stellarscope
label: stellarscope
doc: "Stellarscope is a tool for the quantification of transposable elements (TEs)
  at the single-cell level.\n\nTool homepage: https://github.com/nixonlab/stellarscope"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stellarscope:1.5--py312h0fa9677_1
stdout: stellarscope.out
