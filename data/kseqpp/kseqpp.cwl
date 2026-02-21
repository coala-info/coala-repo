cwlVersion: v1.2
class: CommandLineTool
baseCommand: kseqpp
label: kseqpp
doc: "The provided text does not contain help information for kseqpp. It contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/cartoonist/kseqpp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kseqpp:1.1.2--h077b44d_1
stdout: kseqpp.out
