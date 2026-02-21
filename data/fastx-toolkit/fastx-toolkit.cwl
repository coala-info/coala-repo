cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastx-toolkit
label: fastx-toolkit
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system error messages related to a container runtime (Apptainer/Singularity)
  failing to pull the fastx-toolkit image due to insufficient disk space.\n\nTool
  homepage: https://github.com/agordon/fastx_toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
stdout: fastx-toolkit.out
