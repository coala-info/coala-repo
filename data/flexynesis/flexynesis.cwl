cwlVersion: v1.2
class: CommandLineTool
baseCommand: flexynesis
label: flexynesis
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container runtime (Apptainer/Singularity) failing to pull
  the image due to insufficient disk space.\n\nTool homepage: https://github.com/BIMSBbioinfo/flexynesis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flexynesis:1.1.7--pyhdfd78af_0
stdout: flexynesis.out
