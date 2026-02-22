cwlVersion: v1.2
class: CommandLineTool
baseCommand: blosum
label: blosum
doc: "The provided text does not contain help information or a description of the
  tool. It contains system error messages related to a container runtime failure (no
  space left on device).\n\nTool homepage: https://github.com/not-a-feature/blosum"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blosum:2.2.0--pyhdfd78af_0
stdout: blosum.out
