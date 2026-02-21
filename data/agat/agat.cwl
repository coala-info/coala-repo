cwlVersion: v1.2
class: CommandLineTool
baseCommand: agat
label: agat
doc: "The provided text does not contain help information for the tool. It is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  the image due to lack of disk space.\n\nTool homepage: https://github.com/NBISweden/AGAT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agat:1.6.1--pl5321hdfd78af_1
stdout: agat.out
