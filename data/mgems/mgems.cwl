cwlVersion: v1.2
class: CommandLineTool
baseCommand: mgems
label: mgems
doc: "The provided text does not contain help information for the tool; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  the image due to insufficient disk space.\n\nTool homepage: https://github.com/PROBIC/mGEMS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgems:1.3.3--h13024bc_2
stdout: mgems.out
