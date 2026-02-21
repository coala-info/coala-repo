cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncmpidiff
label: esme_pnetcdf_psmpi_5_12_1_ncmpidiff
doc: "The provided help text contains only system error messages related to a container
  runtime failure and does not provide usage information for the tool.\n\nTool homepage:
  https://parallel-netcdf.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pnetcdf_psmpi_5_12_1_ncmpidiff.out
