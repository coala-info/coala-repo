cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_mpich_4_3_1
label: esme_mpich_4_3_1
doc: "ESME (Energy Exascale Earth System Model) component with NetCDF-Fortran and
  MPICH support. Note: The provided text contains system error logs rather than command-line
  usage instructions.\n\nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_mpich_4_3_1.out
