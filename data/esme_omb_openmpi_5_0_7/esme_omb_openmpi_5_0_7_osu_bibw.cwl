cwlVersion: v1.2
class: CommandLineTool
baseCommand: osu_bibw
label: esme_omb_openmpi_5_0_7_osu_bibw
doc: "OSU MPI Bidirectional Bandwidth Test. (Note: The provided text contains error
  logs and does not list command-line arguments; therefore, the arguments list is
  empty.)\n\nTool homepage: https://mvapich.cse.ohio-state.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_omb_openmpi_5_0_7_osu_bibw.out
