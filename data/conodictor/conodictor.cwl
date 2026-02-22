cwlVersion: v1.2
class: CommandLineTool
baseCommand: conodictor
label: conodictor
doc: "ConoDictor is a tool for the identification and classification of conopeptides.
  (Note: The provided text contains system error messages regarding container execution
  and does not list specific command-line arguments.)\n\nTool homepage: https://github.com/koualab/conodictor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/conodictor:v2.3.1_cv1
stdout: conodictor.out
