cwlVersion: v1.2
class: CommandLineTool
baseCommand: nopilesum
label: nopilesum
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build an image due to insufficient disk space.\n\nTool homepage: https://github.com/blachlylab/nopilesum"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nopilesum:1.1.2--h5884fcd_0
stdout: nopilesum.out
