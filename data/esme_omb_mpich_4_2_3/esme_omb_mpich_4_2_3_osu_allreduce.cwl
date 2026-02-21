cwlVersion: v1.2
class: CommandLineTool
baseCommand: osu_allreduce
label: esme_omb_mpich_4_2_3_osu_allreduce
doc: "OSU MPI Allreduce Benchmark. Note: The provided text contains error logs regarding
  a container build failure and does not list command-line arguments.\n\nTool homepage:
  https://mvapich.cse.ohio-state.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_omb_mpich_4_2_3_osu_allreduce.out
