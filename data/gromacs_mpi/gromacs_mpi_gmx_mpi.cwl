cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmx_mpi
label: gromacs_mpi_gmx_mpi
doc: "GROMACS molecular dynamics package (MPI version). Note: The provided help text
  contains only container runtime error messages and no tool-specific usage information.\n
  \nTool homepage: http://www.gromacs.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacs:2022
stdout: gromacs_mpi_gmx_mpi.out
