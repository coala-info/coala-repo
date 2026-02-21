cwlVersion: v1.2
class: CommandLineTool
baseCommand: alfa
label: alfa
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to lack of disk space.\n\nTool homepage: https://github.com/biocompibens/ALFA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alfa:1.1.1--pyh5e36f6f_0
stdout: alfa.out
