cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanocompore
label: nanocompore
doc: "The provided text does not contain help information for the tool. It contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build the container image due to lack of disk space.\n\nTool homepage: https://github.com/tleonardi/nanocompore"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanocompore:1.0.4--pyhdfd78af_0
stdout: nanocompore.out
