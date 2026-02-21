cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpif90
label: esme_netcdf-fortran_mvapich_4_0_ucx_mpif90
doc: "ESME (Earth System Model Evaluation) tool with NetCDF-Fortran and MVAPICH support.
  Note: The provided help text contains only container runtime error messages and
  does not list specific command-line arguments.\n\nTool homepage: http://www.unidata.ucar.edu/software/netcdf/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_netcdf-fortran_mvapich_4_0_ucx_mpif90.out
