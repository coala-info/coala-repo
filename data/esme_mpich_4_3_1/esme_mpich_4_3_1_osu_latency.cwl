cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_mpich_4_3_1_osu_latency
label: esme_mpich_4_3_1_osu_latency
doc: "OSU Latency benchmark (Note: The provided text contains container runtime error
  logs rather than tool help documentation)\n\nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_mpich_4_3_1_osu_latency.out
