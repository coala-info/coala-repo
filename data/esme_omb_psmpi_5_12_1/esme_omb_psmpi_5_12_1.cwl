cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_omb_psmpi_5_12_1
label: esme_omb_psmpi_5_12_1
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding container image
  conversion and disk space.\n\nTool homepage: https://mvapich.cse.ohio-state.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_omb_psmpi_5_12_1.out
