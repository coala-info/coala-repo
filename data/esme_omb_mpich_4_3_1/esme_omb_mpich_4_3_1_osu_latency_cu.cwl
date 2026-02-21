cwlVersion: v1.2
class: CommandLineTool
baseCommand: osu_latency
label: esme_omb_mpich_4_3_1_osu_latency_cu
doc: "OSU MPI Latency Test (Note: The provided text contains container runtime error
  logs rather than tool help text. No arguments could be extracted from the source.)\n
  \nTool homepage: https://mvapich.cse.ohio-state.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_omb_mpich_4_3_1_osu_latency_cu.out
