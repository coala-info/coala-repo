cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncmpidiff
label: esme_pnetcdf_openmpi_5_0_7_ncmpidiff
doc: "Compare two NetCDF files. (Note: The provided help text contains a system error
  message and does not list specific command-line arguments.)\n\nTool homepage: https://parallel-netcdf.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pnetcdf_openmpi_5_0_7_ncmpidiff.out
