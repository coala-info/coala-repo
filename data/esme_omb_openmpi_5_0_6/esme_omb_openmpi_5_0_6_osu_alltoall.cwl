cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_omb_openmpi_5_0_6_osu_alltoall
label: esme_omb_openmpi_5_0_6_osu_alltoall
doc: "OSU Micro-Benchmarks All-to-All communication test (OpenMPI 5.0.6)\n\nTool homepage:
  https://mvapich.cse.ohio-state.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_omb_openmpi_5_0_6_osu_alltoall.out
