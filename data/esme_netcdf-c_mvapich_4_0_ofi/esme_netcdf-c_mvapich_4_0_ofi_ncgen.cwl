cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncgen
label: esme_netcdf-c_mvapich_4_0_ofi_ncgen
doc: "The ncgen tool generates a netCDF file or a C or Fortran program that creates
  a netCDF file from an input file in CDL (network Common Data form Language) format.\n
  \nTool homepage: http://www.unidata.ucar.edu/software/netcdf/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_netcdf-c_mvapich_4_0_ofi_ncgen.out
