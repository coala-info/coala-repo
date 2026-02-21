cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncgen
label: esme_netcdf-c_openmpi_5_0_6_ncgen
doc: "NetCDF network Common Data form Language (CDL) compiler. Note: The provided
  help text contains system error messages regarding container image retrieval and
  disk space, rather than tool-specific usage instructions.\n\nTool homepage: http://www.unidata.ucar.edu/software/netcdf/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_netcdf-c_openmpi_5_0_6_ncgen.out
