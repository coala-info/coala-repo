cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_mpich_4_2_3_osu_latency
label: esme_mpich_4_2_3_osu_latency
doc: "OSU Micro-Benchmarks latency test (MPICH version)\n\nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_mpich_4_2_3_osu_latency.out
