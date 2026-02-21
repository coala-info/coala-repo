cwlVersion: v1.2
class: CommandLineTool
baseCommand: pylprotpredictor
label: pylprotpredictor
doc: "The provided text contains container runtime logs and error messages rather
  than the tool's help documentation. As a result, no arguments or tool descriptions
  could be extracted.\n\nTool homepage: http://bebatut.fr/PylProtPredictor/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pylprotpredictor:1.0.2--py_0
stdout: pylprotpredictor.out
