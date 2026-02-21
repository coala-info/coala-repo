cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_pnetcdf_openmpi_5_0_7_ncoffsets
label: esme_pnetcdf_openmpi_5_0_7_ncoffsets
doc: "The provided help text contains error logs related to a container runtime failure
  (no space left on device) and does not contain usage information or argument definitions
  for the tool.\n\nTool homepage: https://parallel-netcdf.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pnetcdf_openmpi_5_0_7_ncoffsets.out
