cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanoplexer
label: nanoplexer
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to lack of disk space.\n\nTool homepage: https://github.com/hanyue36/nanoplexer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoplexer:0.1.2--h577a1d6_5
stdout: nanoplexer.out
