cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncdump
label: esme_netcdf-c_psmpi_5_12_1_ncdump
doc: "The ncdump utility generates a text representation of a specified netCDF file
  on standard output.\n\nTool homepage: http://www.unidata.ucar.edu/software/netcdf/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_netcdf-c_psmpi_5_12_1_ncdump.out
