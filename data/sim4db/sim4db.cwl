cwlVersion: v1.2
class: CommandLineTool
baseCommand: sim4db
label: sim4db
doc: The provided text does not contain help information for sim4db; it is an error
  log from a container runtime (Apptainer/Singularity) failing to fetch the image.
  No arguments could be parsed from this text.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sim4db:2008--0
stdout: sim4db.out
