cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_adapters
label: biobb_adapters
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system logs and a fatal error message regarding a container
  build failure (no space left on device).\n\nTool homepage: https://github.com/bioexcel/biobb_adapters"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_adapters:5.1.2--pyhdfd78af_0
stdout: biobb_adapters.out
