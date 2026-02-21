cwlVersion: v1.2
class: CommandLineTool
baseCommand: osu_allreduce
label: esme_omb_mvapich_4_0_osu_allreduce
doc: "OSU Micro-Benchmark for MPI Allreduce (MVAPICH). Note: The provided help text
  contains only container runtime error messages and no command-line argument information.\n
  \nTool homepage: https://mvapich.cse.ohio-state.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_omb_mvapich_4_0_osu_allreduce.out
