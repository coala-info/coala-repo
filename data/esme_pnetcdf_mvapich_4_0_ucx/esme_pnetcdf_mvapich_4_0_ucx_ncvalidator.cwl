cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncvalidator
label: esme_pnetcdf_mvapich_4_0_ucx_ncvalidator
doc: "A tool for validating NetCDF files (Note: The provided help text contained only
  container runtime error logs and no usage information).\n\nTool homepage: https://parallel-netcdf.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pnetcdf_mvapich_4_0_ucx_ncvalidator.out
