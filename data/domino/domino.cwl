cwlVersion: v1.2
class: CommandLineTool
baseCommand: domino
label: domino
doc: "The provided text does not contain help information or usage instructions; it
  is an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to lack of disk space.\n\nTool homepage: https://github.com/Shamir-Lab/DOMINO"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/domino:1.0.0--pyhdfd78af_0
stdout: domino.out
