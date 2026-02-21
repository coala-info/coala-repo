cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_omb_psmpi_5_12_1_osu_latency
label: esme_omb_psmpi_5_12_1_osu_latency
doc: "OSU Latency benchmark. (Note: The provided help text contains container runtime
  error logs and does not list specific command-line arguments or tool descriptions).\n
  \nTool homepage: https://mvapich.cse.ohio-state.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_omb_psmpi_5_12_1_osu_latency.out
