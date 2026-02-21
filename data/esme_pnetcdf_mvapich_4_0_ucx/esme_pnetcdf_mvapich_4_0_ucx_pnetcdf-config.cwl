cwlVersion: v1.2
class: CommandLineTool
baseCommand: pnetcdf-config
label: esme_pnetcdf_mvapich_4_0_ucx_pnetcdf-config
doc: "Configuration utility for Parallel NetCDF (PnetCDF). Note: The provided help
  text contains container runtime error messages and does not list command-line arguments.\n
  \nTool homepage: https://parallel-netcdf.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pnetcdf_mvapich_4_0_ucx_pnetcdf-config.out
