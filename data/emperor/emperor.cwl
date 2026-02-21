cwlVersion: v1.2
class: CommandLineTool
baseCommand: emperor
label: emperor
doc: "The provided text does not contain help information for the tool. It contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to lack of disk space.\n\nTool homepage: https://github.com/kboy-silvergym/ARKit-Emperor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emperor:0.9.3--py27_0
stdout: emperor.out
