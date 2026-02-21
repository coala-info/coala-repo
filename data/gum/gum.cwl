cwlVersion: v1.2
class: CommandLineTool
baseCommand: gum
label: gum
doc: "The provided text does not contain help information for the tool 'gum'. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to lack of disk space.\n\nTool homepage: https://github.com/cartoonist/gum"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gum:2.0.2--h077b44d_1
stdout: gum.out
