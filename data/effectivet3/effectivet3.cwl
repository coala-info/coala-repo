cwlVersion: v1.2
class: CommandLineTool
baseCommand: effectivet3
label: effectivet3
doc: "EffectiveT3 is a tool for the prediction of Type III secretion system (T3SS)
  effector proteins. Note: The provided help text contains only container runtime
  error messages and does not list specific command-line arguments.\n\nTool homepage:
  https://github.com/nicolasrnemeth/EffectiveT3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/effectivet3:1.0.1--py36_0
stdout: effectivet3.out
