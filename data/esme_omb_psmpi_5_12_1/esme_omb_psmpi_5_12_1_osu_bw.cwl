cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_omb_psmpi_5_12_1_osu_bw
label: esme_omb_psmpi_5_12_1_osu_bw
doc: "OSU Micro-Benchmarks (OMB) for MPI Bandwidth (Note: The provided text contains
  container runtime error logs rather than tool help documentation).\n\nTool homepage:
  https://mvapich.cse.ohio-state.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_omb_psmpi_5_12_1_osu_bw.out
