cwlVersion: v1.2
class: CommandLineTool
baseCommand: codan
label: codan
doc: "The provided text does not contain help information for the tool 'codan'. It
  contains error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/pedronachtigall/CodAn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/codan:1.2--hdfd78af_1
stdout: codan.out
