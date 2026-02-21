cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dnarrange
  - lamassemble
label: dnarrange_lamassemble
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container runtime (Apptainer/Singularity) failing to pull
  a Docker image due to insufficient disk space.\n\nTool homepage: https://github.com/mcfrith/dnarrange"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnarrange:1.6.3--pyh7e72e81_0
stdout: dnarrange_lamassemble.out
