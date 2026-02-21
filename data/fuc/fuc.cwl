cwlVersion: v1.2
class: CommandLineTool
baseCommand: fuc
label: fuc
doc: "The provided text does not contain help information for the tool 'fuc'. It contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to pull the container image due to insufficient disk space.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc.out
