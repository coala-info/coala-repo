cwlVersion: v1.2
class: CommandLineTool
baseCommand: maf-convert
label: last_maf-convert
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  build an image due to lack of disk space.\n\nTool homepage: https://gitlab.com/mcfrith/last"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/last:1650--h5ca1c30_0
stdout: last_maf-convert.out
