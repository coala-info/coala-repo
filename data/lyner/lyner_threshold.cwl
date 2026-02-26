cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - threshold
label: lyner_threshold
doc: "Set |data| < value to 0, data >= value to 1, -data >= value to -1.\n\nTool homepage:
  https://github.com/tedil/lyner"
inputs:
  - id: value
    type: float
    doc: Threshold value
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_threshold.out
