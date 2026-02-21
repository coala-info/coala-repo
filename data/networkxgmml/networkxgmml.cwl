cwlVersion: v1.2
class: CommandLineTool
baseCommand: networkxgmml
label: networkxgmml
doc: The provided text does not contain help information for the tool. It contains
  error logs related to a container runtime (Apptainer/Singularity) failing to build
  a SIF image due to insufficient disk space.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/networkxgmml:0.1.6--py36_1
stdout: networkxgmml.out
