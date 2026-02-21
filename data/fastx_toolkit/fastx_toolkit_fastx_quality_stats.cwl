cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastx_quality_stats
label: fastx_toolkit_fastx_quality_stats
doc: "The provided text does not contain help information for the tool. It contains
  a fatal error message regarding container image building (no space left on device).\n
  \nTool homepage: https://github.com/agordon/fastx_toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
stdout: fastx_toolkit_fastx_quality_stats.out
