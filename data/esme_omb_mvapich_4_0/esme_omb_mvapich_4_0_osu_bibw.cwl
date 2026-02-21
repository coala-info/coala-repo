cwlVersion: v1.2
class: CommandLineTool
baseCommand: osu_bibw
label: esme_omb_mvapich_4_0_osu_bibw
doc: "OSU Micro-Benchmarks - Bidirectional Bandwidth. (Note: The provided help text
  contains only container runtime error logs and no CLI usage information.)\n\nTool
  homepage: https://mvapich.cse.ohio-state.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_omb_mvapich_4_0_osu_bibw.out
