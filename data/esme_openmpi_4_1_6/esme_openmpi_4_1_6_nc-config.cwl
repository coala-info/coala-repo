cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_openmpi_4_1_6_nc-config
label: esme_openmpi_4_1_6_nc-config
doc: "NetCDF configuration utility (Note: The provided text contains container runtime
  error logs rather than tool help text, so no arguments could be extracted).\n\n
  Tool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_openmpi_4_1_6_nc-config.out
