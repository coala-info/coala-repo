cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_pnetcdf_mpich_4_3_1_ncoffsets
label: esme_pnetcdf_mpich_4_3_1_ncoffsets
doc: "The provided help text contains only system error messages related to container
  image conversion and disk space issues; no tool-specific usage information or description
  was available.\n\nTool homepage: https://parallel-netcdf.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pnetcdf_mpich_4_3_1_ncoffsets.out
