cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_netcdf-c_mvapich_4_0
label: esme_netcdf-c_mvapich_4_0
doc: "NetCDF-C library with MVAPICH support (Note: The provided text contains system
  error logs rather than tool help documentation; no arguments could be extracted).\n
  \nTool homepage: http://www.unidata.ucar.edu/software/netcdf/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_netcdf-c_mvapich_4_0.out
