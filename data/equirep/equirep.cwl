cwlVersion: v1.2
class: CommandLineTool
baseCommand: equirep
label: equirep
doc: "The provided text does not contain help information for the tool 'equirep'.
  It contains system error messages related to a container runtime (Apptainer/Singularity)
  failing to pull a Docker image due to insufficient disk space.\n\nTool homepage:
  https://github.com/Shao-Group/EquiRep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/equirep:1.0.0--h9948957_0
stdout: equirep.out
