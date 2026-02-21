cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gmx_mpi
label: gromacs_gmx_mpi
doc: "GROMACS molecular dynamics package (MPI version). Note: The provided text contains
  container runtime error messages and does not include tool-specific help documentation
  or arguments.\n\nTool homepage: https://www.gromacs.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacs:2022
stdout: gromacs_gmx_mpi.out
