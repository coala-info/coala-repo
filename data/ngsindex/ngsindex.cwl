cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngsindex
label: ngsindex
doc: "The provided text does not contain help information or usage instructions for
  the tool; it consists of system error messages regarding a container runtime failure
  (no space left on device).\n\nTool homepage: https://github.com/jdidion/ngsindex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsindex:0.1.7--pyh7cba7a3_0
stdout: ngsindex.out
