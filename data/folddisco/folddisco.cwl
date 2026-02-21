cwlVersion: v1.2
class: CommandLineTool
baseCommand: folddisco
label: folddisco
doc: "The provided text does not contain help information or usage instructions for
  folddisco. It contains system log messages and a fatal error regarding a container
  build failure (no space left on device).\n\nTool homepage: https://github.com/steineggerlab/folddisco"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/folddisco:1.7514114--ha6fb395_0
stdout: folddisco.out
