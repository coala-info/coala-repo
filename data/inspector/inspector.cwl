cwlVersion: v1.2
class: CommandLineTool
baseCommand: inspector
label: inspector
doc: "The provided text does not contain help information or usage instructions for
  the tool 'inspector'. It contains system logs and a fatal error message regarding
  a container build failure (no space left on device).\n\nTool homepage: https://github.com/ChongLab/Inspector"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/inspector:1.3.1--hdfd78af_1
stdout: inspector.out
