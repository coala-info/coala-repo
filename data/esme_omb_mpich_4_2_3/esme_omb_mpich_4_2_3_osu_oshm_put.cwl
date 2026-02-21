cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_omb_mpich_4_2_3_osu_oshm_put
label: esme_omb_mpich_4_2_3_osu_oshm_put
doc: "OSU Micro-Benchmarks for OpenSHMEM (oshm_put). Note: The provided help text
  contains only container runtime error messages and no command-line argument definitions.\n
  \nTool homepage: https://mvapich.cse.ohio-state.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_omb_mpich_4_2_3_osu_oshm_put.out
