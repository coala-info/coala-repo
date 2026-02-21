cwlVersion: v1.2
class: CommandLineTool
baseCommand: gofasta
label: gofasta
doc: "The provided text does not contain help information for the tool; it contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to lack of disk space.\n\nTool homepage: https://github.com/cov-ert/gofasta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0
stdout: gofasta.out
