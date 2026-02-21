cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_openmpi_5_0_6_pnetcdf-config
label: esme_openmpi_5_0_6_pnetcdf-config
doc: "A configuration utility for PNetCDF. (Note: The provided help text contains
  error messages from the container runtime and does not list available arguments.)\n
  \nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_openmpi_5_0_6_pnetcdf-config.out
