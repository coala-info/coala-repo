cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_omb_openmpi_5_0_6_osu_bw
label: esme_omb_openmpi_5_0_6_osu_bw
doc: "OSU Micro-Benchmarks bandwidth test (OpenMPI version). Note: The provided help
  text contains only container runtime error messages and no usage information.\n\n
  Tool homepage: https://mvapich.cse.ohio-state.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_omb_openmpi_5_0_6_osu_bw.out
