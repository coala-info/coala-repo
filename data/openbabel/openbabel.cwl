cwlVersion: v1.2
class: CommandLineTool
baseCommand: openbabel
label: openbabel
doc: "The provided text does not contain help information for openbabel; it contains
  error messages from a container runtime (Apptainer/Singularity) indicating a failure
  to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/openbabel/openbabel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/openbabel:3.1.1--2
stdout: openbabel.out
