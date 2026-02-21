cwlVersion: v1.2
class: CommandLineTool
baseCommand: functools32
label: functools32
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container runtime (Apptainer/Singularity) failing to pull
  a Docker image due to lack of disk space.\n\nTool homepage: https://github.com/michilu/python-functools32"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/functools32:3.2.3.2--py27_0
stdout: functools32.out
