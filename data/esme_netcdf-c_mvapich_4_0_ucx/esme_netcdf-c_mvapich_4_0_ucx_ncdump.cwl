cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncdump
label: esme_netcdf-c_mvapich_4_0_ucx_ncdump
doc: "The provided text does not contain help information as it reports a fatal error
  regarding disk space during a container build process. ncdump is typically used
  to convert NetCDF files to text form (CDL).\n\nTool homepage: http://www.unidata.ucar.edu/software/netcdf/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_netcdf-c_mvapich_4_0_ucx_ncdump.out
