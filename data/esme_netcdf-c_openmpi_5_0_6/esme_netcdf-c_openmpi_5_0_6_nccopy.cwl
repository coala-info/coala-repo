cwlVersion: v1.2
class: CommandLineTool
baseCommand: nccopy
label: esme_netcdf-c_openmpi_5_0_6_nccopy
doc: "NetCDF copy utility (Note: The provided help text contains system error messages
  regarding container image building and does not list command-line arguments).\n\n
  Tool homepage: http://www.unidata.ucar.edu/software/netcdf/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_netcdf-c_openmpi_5_0_6_nccopy.out
