cwlVersion: v1.2
class: CommandLineTool
baseCommand: pondus
label: pondus
doc: "The provided text does not contain help information for the tool 'pondus'. It
  contains system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull a Docker image due to insufficient disk space.\n\nTool homepage:
  https://github.com/enicklas/pondus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pondus:v0.8.0-4-deb_cv1
stdout: pondus.out
