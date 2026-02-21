cwlVersion: v1.2
class: CommandLineTool
baseCommand: nc-config
label: esme_openmpi_5_0_6_nc-config
doc: "NetCDF configuration utility (Note: The provided help text contains only system
  error messages and no usage information).\n\nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_openmpi_5_0_6_nc-config.out
