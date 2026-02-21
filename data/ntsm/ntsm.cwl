cwlVersion: v1.2
class: CommandLineTool
baseCommand: ntsm
label: ntsm
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to insufficient disk space.\n\nTool
  homepage: https://github.com/JustinChu/ntsm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntsm:1.2.1--h077b44d_1
stdout: ntsm.out
