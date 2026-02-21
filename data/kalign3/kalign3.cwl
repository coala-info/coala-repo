cwlVersion: v1.2
class: CommandLineTool
baseCommand: kalign
label: kalign3
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime failure (no space left
  on device).\n\nTool homepage: https://github.com/TimoLassmann/kalign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kalign3:3.4.0--h503566f_2
stdout: kalign3.out
