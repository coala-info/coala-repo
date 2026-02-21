cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_psmpi_5_10_0_pnetcdf-config
label: esme_psmpi_5_10_0_pnetcdf-config
doc: "A configuration tool for PNetCDF (Note: The provided text contains environment
  error messages rather than tool help documentation).\n\nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_psmpi_5_10_0_pnetcdf-config.out
