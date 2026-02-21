cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq_quality_filter
label: fastx-toolkit_fastq_quality_filter
doc: "The provided text does not contain help information or a description of the
  tool. It contains system error messages related to a container runtime failure (no
  space left on device).\n\nTool homepage: https://github.com/agordon/fastx_toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
stdout: fastx-toolkit_fastq_quality_filter.out
