cwlVersion: v1.2
class: CommandLineTool
baseCommand: dwgsim
label: dwgsim
doc: "The provided text does not contain help information for dwgsim. It contains
  a fatal error message from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to lack of disk space.\n\nTool homepage: https://github.com/nh13/DWGSIM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dwgsim:1.1.14--h96c455f_2
stdout: dwgsim.out
