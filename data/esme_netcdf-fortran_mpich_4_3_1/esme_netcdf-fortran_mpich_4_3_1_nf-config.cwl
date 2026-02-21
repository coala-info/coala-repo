cwlVersion: v1.2
class: CommandLineTool
baseCommand: nf-config
label: esme_netcdf-fortran_mpich_4_3_1_nf-config
doc: "NetCDF-Fortran configuration utility. (Note: The provided help text contains
  only container runtime error messages and does not list specific tool arguments.)\n
  \nTool homepage: http://www.unidata.ucar.edu/software/netcdf/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_netcdf-fortran_mpich_4_3_1_nf-config.out
