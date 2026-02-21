cwlVersion: v1.2
class: CommandLineTool
baseCommand: osu_alltoall
label: esme_omb_mpich_4_2_3_osu_alltoall
doc: "OSU Micro-Benchmarks (OMB) All-to-All MPI benchmark. Note: The provided help
  text contains only system error messages regarding container image building and
  disk space, and does not list command-line arguments.\n\nTool homepage: https://mvapich.cse.ohio-state.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_omb_mpich_4_2_3_osu_alltoall.out
