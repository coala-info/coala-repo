cwlVersion: v1.2
class: CommandLineTool
baseCommand: fqzcomp
label: fqzcomp
doc: "The provided text does not contain help information for fqzcomp; it contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  pull the image due to lack of disk space.\n\nTool homepage: https://sourceforge.net/projects/fqzcomp/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fqzcomp:4.6--h077b44d_6
stdout: fqzcomp.out
