cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdpc
label: gdpc
doc: "The provided text does not contain help information for the tool 'gdpc'. It
  contains error logs related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/avdstaaij/gdpc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gdpc:v2.2.5-9-deb_cv1
stdout: gdpc.out
