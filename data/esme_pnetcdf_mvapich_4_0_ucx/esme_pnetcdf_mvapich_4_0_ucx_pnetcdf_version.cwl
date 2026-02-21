cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_pnetcdf_mvapich_4_0_ucx_pnetcdf_version
label: esme_pnetcdf_mvapich_4_0_ucx_pnetcdf_version
doc: "A tool for checking the version or configuration of ESME with PNetCDF and MVAPICH
  support. (Note: The provided text contains container runtime error logs and does
  not list specific command-line arguments.)\n\nTool homepage: https://parallel-netcdf.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pnetcdf_mvapich_4_0_ucx_pnetcdf_version.out
