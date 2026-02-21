cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncgen
label: esme_netcdf-c_openmpi_4_1_6_ncgen
doc: "The ncgen tool generates a NetCDF file or a C or Fortran program that creates
  a NetCDF file from an input CDL (network Common Data form Language) file.\n\nTool
  homepage: http://www.unidata.ucar.edu/software/netcdf/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_netcdf-c_openmpi_4_1_6_ncgen.out
