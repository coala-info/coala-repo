cwlVersion: v1.2
class: CommandLineTool
baseCommand: osu_bw
label: esme_omb_mpich_4_2_3_osu_bw
doc: "OSU Micro-Benchmarks Bandwidth test (MPICH version). Note: The provided text
  contains system error logs rather than tool help documentation; no arguments could
  be extracted.\n\nTool homepage: https://mvapich.cse.ohio-state.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_omb_mpich_4_2_3_osu_bw.out
