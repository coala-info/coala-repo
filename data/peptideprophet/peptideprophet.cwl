cwlVersion: v1.2
class: CommandLineTool
baseCommand: peptideprophet
label: peptideprophet
doc: "The provided text does not contain help documentation or usage instructions.
  It consists of system error messages related to a container execution failure (no
  space left on device).\n\nTool homepage: https://github.com/PNNL-Comp-Mass-Spec/PeptideProphetLibrary"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/peptideprophet:v201510131012_cv3
stdout: peptideprophet.out
