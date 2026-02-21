cwlVersion: v1.2
class: CommandLineTool
baseCommand: greenhill
label: greenhill
doc: "The provided text does not contain help information for the tool 'greenhill'.
  It contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build a SIF image due to lack of disk space.\n\nTool homepage: https://github.com/ShunOuchi/GreenHill"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/greenhill:1.1.0--h663a4a6_3
stdout: greenhill.out
