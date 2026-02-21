cwlVersion: v1.2
class: CommandLineTool
baseCommand: lrzuntar
label: lrzip_lrzuntar
doc: "The provided text does not contain help information for the tool, but rather
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build an image due to lack of disk space.\n\nTool homepage: https://github.com/ckolivas/lrzip"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrzip:0.651--h32784b6_1
stdout: lrzip_lrzuntar.out
