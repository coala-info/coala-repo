cwlVersion: v1.2
class: CommandLineTool
baseCommand: pnetcdf-config
label: esme_pnetcdf_mpich_4_3_1_pnetcdf-config
doc: "A configuration utility for the PnetCDF (Parallel NetCDF) library. Note: The
  provided input text contains system error messages regarding container image creation
  and does not include the actual help documentation for the tool.\n\nTool homepage:
  https://parallel-netcdf.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pnetcdf_mpich_4_3_1_pnetcdf-config.out
