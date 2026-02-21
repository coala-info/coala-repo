cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastx_clipper
label: fastx-toolkit_fastx_clipper
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/agordon/fastx_toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
stdout: fastx-toolkit_fastx_clipper.out
