cwlVersion: v1.2
class: CommandLineTool
baseCommand: last
label: last
doc: "The provided text does not contain help information for the 'last' command.
  It is an error log from a container runtime (Apptainer/Singularity) indicating a
  failure to build the SIF image due to insufficient disk space.\n\nTool homepage:
  https://gitlab.com/mcfrith/last"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/last:1650--h5ca1c30_0
stdout: last.out
