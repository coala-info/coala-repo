cwlVersion: v1.2
class: CommandLineTool
baseCommand: mummer4
label: mummer4
doc: "The provided text does not contain help information for mummer4; it contains
  a fatal error message from a container runtime (Singularity/Apptainer) indicating
  a failure to build the image due to lack of disk space.\n\nTool homepage: https://mummer4.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
stdout: mummer4.out
