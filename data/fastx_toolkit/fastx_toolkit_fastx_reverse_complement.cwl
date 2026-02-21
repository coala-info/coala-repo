cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastx_reverse_complement
label: fastx_toolkit_fastx_reverse_complement
doc: "The provided text does not contain help information for the tool, as it is an
  error message indicating a failure to build or run the container (no space left
  on device).\n\nTool homepage: https://github.com/agordon/fastx_toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
stdout: fastx_toolkit_fastx_reverse_complement.out
