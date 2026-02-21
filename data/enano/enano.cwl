cwlVersion: v1.2
class: CommandLineTool
baseCommand: enano
label: enano
doc: "The provided text does not contain help information for the tool 'enano'. It
  contains error logs related to a container runtime (Apptainer/Singularity) failure
  due to insufficient disk space.\n\nTool homepage: https://github.com/guilledufort/EnanoFASTQ"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enano:1.0--hd03093a_4
stdout: enano.out
