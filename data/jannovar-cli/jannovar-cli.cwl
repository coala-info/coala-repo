cwlVersion: v1.2
class: CommandLineTool
baseCommand: jannovar-cli
label: jannovar-cli
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error logs related to a container runtime failure (no space
  left on device).\n\nTool homepage: https://github.com/charite/jannovar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jannovar-cli:0.36--hdfd78af_0
stdout: jannovar-cli.out
