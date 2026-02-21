cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncmpidiff
label: esme_pnetcdf_mpich_4_3_1_ncmpidiff
doc: "A tool to compare two NetCDF files for differences. (Note: The provided help
  text contains system error messages rather than tool usage information; no arguments
  could be extracted from the source text).\n\nTool homepage: https://parallel-netcdf.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pnetcdf_mpich_4_3_1_ncmpidiff.out
