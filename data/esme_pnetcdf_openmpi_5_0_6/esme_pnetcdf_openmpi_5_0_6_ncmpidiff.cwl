cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncmpidiff
label: esme_pnetcdf_openmpi_5_0_6_ncmpidiff
doc: "A tool to compare two PnetCDF files. Note: The provided help text contains only
  system error messages regarding container image conversion and disk space, and does
  not list command-line arguments.\n\nTool homepage: https://parallel-netcdf.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pnetcdf_openmpi_5_0_6_ncmpidiff.out
