cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmannot
label: mmannot
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) indicating
  a failure to pull or build the container image due to insufficient disk space.\n
  \nTool homepage: https://github.com/mzytnicki/mmannot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmannot:1.1--h077b44d_3
stdout: mmannot.out
