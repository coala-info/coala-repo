cwlVersion: v1.2
class: CommandLineTool
baseCommand: f5c
label: f5c
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container runtime (Apptainer/Singularity) failing to pull
  the f5c image due to lack of disk space.\n\nTool homepage: https://github.com/hasindu2008/f5c"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/f5c:1.6--hee927d3_0
stdout: f5c.out
