cwlVersion: v1.2
class: CommandLineTool
baseCommand: coast
label: coast
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to pull the image due to lack of disk space.\n\nTool homepage: https://gitlab.com/coast_tool/COAST"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coast:0.2.2--pyh5e36f6f_0
stdout: coast.out
