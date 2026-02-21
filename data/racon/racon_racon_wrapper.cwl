cwlVersion: v1.2
class: CommandLineTool
baseCommand: racon
label: racon_racon_wrapper
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Singularity/Apptainer)
  while attempting to fetch the Racon container image.\n\nTool homepage: https://github.com/lbcb-sci/racon"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/racon:1.5.0--h077b44d_8
stdout: racon_racon_wrapper.out
