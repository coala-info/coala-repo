cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_omb_openmpi_4_1_6_osu_bcast
label: esme_omb_openmpi_4_1_6_osu_bcast
doc: "OSU Micro-Benchmark for Broadcast (Bcast) using OpenMPI\n\nTool homepage: https://mvapich.cse.ohio-state.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_omb_openmpi_4_1_6_osu_bcast.out
