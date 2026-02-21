cwlVersion: v1.2
class: CommandLineTool
baseCommand: fqtrim
label: fqtrim
doc: "The provided text does not contain help information for fqtrim; it contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  build an image due to lack of disk space.\n\nTool homepage: https://ccb.jhu.edu/software/fqtrim/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fqtrim:0.9.7--h077b44d_7
stdout: fqtrim.out
