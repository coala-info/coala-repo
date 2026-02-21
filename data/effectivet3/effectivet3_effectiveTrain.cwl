cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - effectivet3
  - effectiveTrain
label: effectivet3_effectiveTrain
doc: "EffectiveT3: Prediction of Type III Secretion System (T3SS) effector proteins
  (Note: The provided help text contains only container runtime error messages and
  no usage information).\n\nTool homepage: https://github.com/nicolasrnemeth/EffectiveT3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/effectivet3:1.0.1--py36_0
stdout: effectivet3_effectiveTrain.out
