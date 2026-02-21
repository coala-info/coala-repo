cwlVersion: v1.2
class: CommandLineTool
baseCommand: nc-config
label: esme_netcdf-c_mvapich_4_0_ucx_nc-config
doc: "NetCDF configuration utility (Note: The provided help text contains only system
  error logs regarding container image building and disk space issues, so no specific
  arguments could be extracted).\n\nTool homepage: http://www.unidata.ucar.edu/software/netcdf/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_netcdf-c_mvapich_4_0_ucx_nc-config.out
