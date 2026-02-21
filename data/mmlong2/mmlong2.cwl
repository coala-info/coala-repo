cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmlong2
label: mmlong2
doc: "The provided text does not contain help information or usage instructions; it
  consists of system error messages related to a container runtime failure (no space
  left on device).\n\nTool homepage: https://github.com/Serka-M/mmlong2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmlong2:1.2.1--hdfd78af_1
stdout: mmlong2.out
