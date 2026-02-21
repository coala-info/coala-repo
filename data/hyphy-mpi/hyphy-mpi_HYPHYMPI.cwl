cwlVersion: v1.2
class: CommandLineTool
baseCommand: HYPHYMPI
label: hyphy-mpi_HYPHYMPI
doc: "The provided text does not contain help information for the tool; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  or run the container due to insufficient disk space.\n\nTool homepage: http://hyphy.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hyphy-mpi:v2.3.14dfsg-1-deb_cv1
stdout: hyphy-mpi_HYPHYMPI.out
