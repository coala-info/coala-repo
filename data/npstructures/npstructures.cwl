cwlVersion: v1.2
class: CommandLineTool
baseCommand: npstructures
label: npstructures
doc: "The provided text does not contain help information for npstructures; it is
  an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build the container due to lack of disk space.\n\nTool homepage: https://github.com/bionumpy/npstructures"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/npstructures:0.2.19--pyh05cac1d_1
stdout: npstructures.out
