cwlVersion: v1.2
class: CommandLineTool
baseCommand: inforna
label: inforna
doc: "The provided text does not contain help information or usage instructions for
  the tool 'inforna'. It contains error messages related to a container runtime (Apptainer/Singularity)
  failing to pull a Docker image due to insufficient disk space.\n\nTool homepage:
  https://github.com/iamadawra/inforna"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/inforna:2.1.2--0
stdout: inforna.out
