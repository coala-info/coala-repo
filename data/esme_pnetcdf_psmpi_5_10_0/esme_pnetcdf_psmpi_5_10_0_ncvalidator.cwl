cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncvalidator
label: esme_pnetcdf_psmpi_5_10_0_ncvalidator
doc: "A tool for validating NetCDF files. (Note: The provided help text contains system
  error messages regarding container image conversion and disk space, rather than
  command-line usage instructions.)\n\nTool homepage: https://parallel-netcdf.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pnetcdf_psmpi_5_10_0_ncvalidator.out
