cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_psmpi_5_12_1_mpifort
label: esme_psmpi_5_12_1_mpifort
doc: "ESME MPI Fortran compiler/wrapper (Note: The provided text contains system error
  logs regarding container image creation and does not include usage instructions
  or argument definitions).\n\nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_psmpi_5_12_1_mpifort.out
