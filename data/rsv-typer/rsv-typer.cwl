cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsv-typer
label: rsv-typer
doc: "The provided text does not contain help information for rsv-typer; it is an
  error log from a container runtime (Singularity/Apptainer) failing to pull the image.\n
  \nTool homepage: https://github.com/DiltheyLab/RSVTyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsv-typer:0.5.0--pyh7e72e81_0
stdout: rsv-typer.out
