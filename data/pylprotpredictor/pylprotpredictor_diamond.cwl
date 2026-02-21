cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pylprotpredictor
  - diamond
label: pylprotpredictor_diamond
doc: "A tool for predicting lipoproteins using Diamond. Note: The provided text contains
  only environment logs and a fatal error regarding container image retrieval, so
  no specific arguments could be extracted.\n\nTool homepage: http://bebatut.fr/PylProtPredictor/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pylprotpredictor:1.0.2--py_0
stdout: pylprotpredictor_diamond.out
