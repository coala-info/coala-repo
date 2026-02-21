cwlVersion: v1.2
class: CommandLineTool
baseCommand: multixrank
label: multixrank
doc: "The provided text does not contain help information or usage instructions; it
  is an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build the container due to lack of disk space.\n\nTool homepage: https://multixrank.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multixrank:0.3--pyh7e72e81_0
stdout: multixrank.out
