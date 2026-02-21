cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_pnetcdf_psmpi_5_12_1
label: esme_pnetcdf_psmpi_5_12_1
doc: "The provided text contains error logs related to a container runtime failure
  (no space left on device) and does not contain help documentation or usage instructions
  for the tool. As a result, no arguments could be parsed.\n\nTool homepage: https://parallel-netcdf.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pnetcdf_psmpi_5_12_1.out
