cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastppm
label: fastppm
doc: "The provided text does not contain help documentation for fastppm; it contains
  system error logs regarding a container execution failure (no space left on device).\n
  \nTool homepage: https://github.com/elkebir-group/fastppm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastppm:1.1.1--py39h2de1943_0
stdout: fastppm.out
