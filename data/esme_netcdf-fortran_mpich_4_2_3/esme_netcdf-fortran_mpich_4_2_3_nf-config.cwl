cwlVersion: v1.2
class: CommandLineTool
baseCommand: nf-config
label: esme_netcdf-fortran_mpich_4_2_3_nf-config
doc: "A utility to retrieve configuration information for the NetCDF-Fortran library.\n
  \nTool homepage: http://www.unidata.ucar.edu/software/netcdf/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_netcdf-fortran_mpich_4_2_3_nf-config.out
