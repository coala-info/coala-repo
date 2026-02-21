cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_netcdf-fortran_psmpi_5_10_0
label: esme_netcdf-fortran_psmpi_5_10_0
doc: "A tool related to NetCDF-Fortran with PSMPI support. (Note: The provided text
  contains container execution error logs rather than command-line help documentation,
  so no arguments could be extracted.)\n\nTool homepage: http://www.unidata.ucar.edu/software/netcdf/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_netcdf-fortran_psmpi_5_10_0.out
