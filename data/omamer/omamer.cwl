cwlVersion: v1.2
class: CommandLineTool
baseCommand: omamer
label: omamer
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container runtime (Apptainer/Singularity) failure due to
  insufficient disk space.\n\nTool homepage: https://github.com/DessimozLab/omamer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/omamer:2.1.2--pyhdfd78af_0
stdout: omamer.out
