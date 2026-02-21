cwlVersion: v1.2
class: CommandLineTool
baseCommand: ntsmCount
label: ntsm_ntsmCount
doc: "The provided text does not contain help information for the tool, but rather
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build the container due to lack of disk space.\n\nTool homepage: https://github.com/JustinChu/ntsm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntsm:1.2.1--h077b44d_1
stdout: ntsm_ntsmCount.out
