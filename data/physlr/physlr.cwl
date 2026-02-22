cwlVersion: v1.2
class: CommandLineTool
baseCommand: physlr
label: physlr
doc: "The provided text does not contain help information for the tool; it contains
  system error messages related to a container runtime failure (no space left on device).\n\
  \nTool homepage: https://github.com/bcgsc/physlr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h9948957_7
stdout: physlr.out
