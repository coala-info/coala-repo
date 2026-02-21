cwlVersion: v1.2
class: CommandLineTool
baseCommand: epicore
label: epicore
doc: "The provided text does not contain help information for the tool. It contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build the container image due to lack of disk space.\n\nTool homepage: https://github.com/AG-Walz/epicore"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epicore:0.1.7--pyhdfd78af_0
stdout: epicore.out
