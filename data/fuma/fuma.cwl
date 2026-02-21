cwlVersion: v1.2
class: CommandLineTool
baseCommand: fuma
label: fuma
doc: "The provided text does not contain help information for the tool 'fuma'. It
  contains error messages from a container runtime (Apptainer/Singularity) indicating
  a failure to pull or build the container image due to insufficient disk space.\n
  \nTool homepage: https://github.com/yhoogstrate/fuma/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuma:4.0.0--pyhb7b1952_0
stdout: fuma.out
