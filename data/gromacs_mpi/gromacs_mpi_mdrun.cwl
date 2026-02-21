cwlVersion: v1.2
class: CommandLineTool
baseCommand: gromacs_mpi_mdrun
label: gromacs_mpi_mdrun
doc: "GROMACS molecular dynamics solver (MPI version). Note: The provided text is
  a container runtime error log and does not contain help documentation or argument
  definitions.\n\nTool homepage: http://www.gromacs.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacs:2022
stdout: gromacs_mpi_mdrun.out
