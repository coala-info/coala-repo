cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_omb_mvapich_4_0_osu_launcher
label: esme_omb_mvapich_4_0_osu_launcher
doc: "Launcher for OSU Micro-Benchmarks (OMB) using MVAPICH. Note: The provided help
  text contains only system error logs regarding container image building and does
  not list specific command-line arguments.\n\nTool homepage: https://mvapich.cse.ohio-state.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_omb_mvapich_4_0_osu_launcher.out
