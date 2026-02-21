cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_omb_mvapich_4_0
label: esme_omb_mvapich_4_0
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system error messages related to container image conversion
  and disk space issues.\n\nTool homepage: https://mvapich.cse.ohio-state.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_omb_mvapich_4_0.out
