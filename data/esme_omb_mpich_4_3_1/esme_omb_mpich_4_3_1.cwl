cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_omb_mpich_4_3_1
label: esme_omb_mpich_4_3_1
doc: "The provided text contains error logs from a container runtime environment rather
  than help documentation for the tool. No command-line arguments, flags, or usage
  instructions could be extracted.\n\nTool homepage: https://mvapich.cse.ohio-state.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_omb_mpich_4_3_1.out
