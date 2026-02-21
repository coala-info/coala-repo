cwlVersion: v1.2
class: CommandLineTool
baseCommand: dodge_dodge.py
label: dodge_dodge.py
doc: "DODGE (Diagnostic Odds Ratio Generator and Evaluator) tool for evaluating diagnostic
  tests.\n\nTool homepage: https://github.com/LanLab/dodge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dodge:1.0.1--pyhdfd78af_0
stdout: dodge_dodge.py.out
