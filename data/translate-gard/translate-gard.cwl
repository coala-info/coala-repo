cwlVersion: v1.2
class: CommandLineTool
baseCommand: translate-gard
label: translate-gard
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system logs and a fatal error message regarding a container
  build failure (no space left on device).\n\nTool homepage: https://github.com/veg/translate-gard/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/translate-gard:1.0.4--0
stdout: translate-gard.out
